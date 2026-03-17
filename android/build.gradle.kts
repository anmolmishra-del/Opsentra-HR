import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

// 🔥 REQUIRED FOR FIREBASE (MUST BE buildscript)
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
    }
}

// 🔹 Repositories for all modules
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 🔹 Custom build directory (OK)
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

// 🔹 Subproject build dirs
subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// 🔹 Ensure app module evaluated first
subprojects {
    project.evaluationDependsOn(":app")
}

// 🔹 Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
