# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# Supabase & Postgrest
-keep class io.supabase.** { *; }
-keep class com.google.protobuf.** { *; }
-dontwarn io.supabase.**
-dontwarn com.google.protobuf.**
-keepclassmembers class * {
    *** *Supabase*(...);  
}

# Retrofit
-keepattributes Signature
-keepattributes *Annotation*
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**
-dontwarn okhttp3.**
-dontwarn okio.**

# OkHttp
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**

# Google Maps
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Riverpod (State Management)
-keep class riverpod.** { *; }
-keep class flutter_riverpod.** { *; }
-keep class riverpod_annotation.** { *; }
-dontwarn riverpod.**
-dontwarn flutter_riverpod.**
-dontwarn riverpod_annotation.**
-keepclassmembers class * {
    *** *Provider*(...);  
    *** *Notifier*(...);  
}
-keep class * extends riverpod.StateNotifier { *; }
-keep class * extends riverpod.AsyncNotifier { *; }

# GoRouter (Navigation)
-keep class go_router.** { *; }
-dontwarn go_router.**
-keepclassmembers class * {
    *** *Router*(...);  
    *** *Route*(...);  
}

# Record Package (Data Classes)
-keep class record.** { *; }
-dontwarn record.**
-keepclassmembers class * {
    *** record(...);  
}

# Speech to Text & Audio
-keep class speech_to_text.** { *; }
-keep class record.** { *; }
-dontwarn speech_to_text.**
-dontwarn record.**
-keepclassmembers class * {
    *** *Speech*(...);  
    *** *Audio*(...);  
    *** *Microphone*(...);  
}

# Dio HTTP Client
-keep class dio.** { *; }
-dontwarn dio.**
-keepclassmembers class * {
    *** *Dio*(...);  
    *** *Interceptor*(...);  
}

# Image Processing
-keep class image.** { *; }
-keep class flutter_image_compress.** { *; }
-dontwarn image.**
-dontwarn flutter_image_compress.**

# QR Code
-keep class qr_flutter.** { *; }
-dontwarn qr_flutter.**

# Logger
-keep class logger.** { *; }
-dontwarn logger.**

# Connectivity
-keep class connectivity_plus.** { *; }
-dontwarn connectivity_plus.**

# Web Socket
-keep class web_socket_channel.** { *; }
-dontwarn web_socket_channel.**

# Kotlin
-keep class kotlin.** { *; }
-keep interface kotlin.** { *; }
-keep class kotlinx.** { *; }
-keep interface kotlinx.** { *; }
-dontwarn kotlin.**
-dontwarn kotlinx.**
-keepclassmembers class * {
    *** kotlin*(...);  
}

# Keep your app's models
-keep class com.rihlaty.rihlaty_app.** { *; }

# Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep Parcelable implementations
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep Serializable implementations
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep constructors for views
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

# Keep R classes
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Optimization settings
-optimizationpasses 5
-dontusemixedcaseclassnames
-verbose

# Remove logging in release builds
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
    public static *** w(...);
}

# Keep line numbers for crash reporting
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Keep annotations
-keepattributes *Annotation*
-keep @interface * { *; }
-keepclassmembers class * {
    @** <fields>;
    @** <methods>;
}

# Prevent obfuscation of critical classes
-keep class * extends android.app.Activity { *; }
-keep class * extends android.app.Service { *; }
-keep class * extends android.content.BroadcastReceiver { *; }
-keep class * extends android.content.ContentProvider { *; }
-keep class * extends android.app.Fragment { *; }
-keep class * extends androidx.fragment.app.Fragment { *; }

# Keep Flutter engine classes
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.view.** { *; }

# Keep all public methods and fields
-keepclasseswithmembers class * {
    public <init>(...);
    public <methods>;
    public <fields>;
}
