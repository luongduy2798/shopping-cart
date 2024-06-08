init: pub-get

clean:
	fvm flutter clean

pub-get:
	fvm flutter pub get

gen-locale:
	fvm flutter gen-l10n

gen:
	fvm flutter pub run build_runner build

gen-conflict:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

clear-cocoa-pod:
	rm -rf ~/Library/Caches/CocoaPods
	rm -rf ~/Library/Developer/Xcode/DerivedData/*
	cd ios && rm -rf Pods
	cd ios && pod deintegrate
	cd ios && pod setup
	cd ios && pod install

pod-install:
	cd ios && rm -rf Pods && rm -rf build && rm -rf Podfile.lock && pod install && cd ..

run:
	fvm flutter run

run-web:
	flutter run -d chrome

apk:
	flutter build apk

aab:
	flutter build appbundle --release

sha:
	cd android && ./gradlew signingReport

release-web:
	flutter build web
