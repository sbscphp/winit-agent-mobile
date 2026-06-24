## 1. Flutter wrapper
# Essential rules to keep the Flutter engine and its plugins functional
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.engine.plugins.** { *; }
-dontwarn io.flutter.embedding.**

## 2. Firebase
# Keeps Firebase SDKs from breaking during shrinking
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

## 3. QoreID (Identity Verification)
# We keep the QoreID SDK intact, but the rest of YOUR app will be obfuscated
-keep class com.qoreid.sdk.** { *; }
-keep interface com.qoreid.sdk.** { *; }
-dontwarn com.qoreid.sdk.**

## 4. Your App Specifics (com.hopegainltd.winitagent)
# This protects the entry point of your app and your data models
-keep class com.hopegainltd.winitagent.MainActivity { *; }
-keep class com.hopegainltd.winitagent.models.** { *; }

## 5. Global R8/ProGuard Settings
# Allows R8 to perform aggressive obfuscation as requested by the VAPT report
-ignorewarnings
-keepattributes Signature, *Annotation*, EnclosingMethod, InnerClasses, SourceFile, LineNumberTable

# These two lines ensure that stack traces can still be de-obfuscated by you later
-renamesourcefileattribute SourceFile
-keepattributes SourceFile,LineNumberTable






### Flutter wrapper
# -keep class io.flutter.app.** { *; }
# -keep class io.flutter.plugin.** { *; }
# -keep class io.flutter.util.** { *; }
# -keep class io.flutter.view.** { *; }
# -keep class io.flutter.** { *; }
# -keep class io.flutter.plugins.** { *; }
# -keep class com.google.firebase.** { *; }
# -dontwarn io.flutter.embedding.**
# -ignorewarnings
#
## QoreID
#-keep class com.qoreid.sdk.** { *; }
#-dontshrink
#-dontobfuscate
#-dontoptimize