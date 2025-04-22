

buildscript {

    val kotlinVersion = "1.7.10"

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // START: FlutterFire Configuration
        classpath("com.google.gms:google-services:4.3.15")
        // END: FlutterFire Configuration
        classpath("com.android.tools.build:gradle:7.3.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion") // ✅ Use the variable directly
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
