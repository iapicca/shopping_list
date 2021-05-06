# shopping_list

### quick look

you can have a *preview* of app with its web version at this [link](https://festive-northcutt-b54e97.netlify.app)

## GOALS

this is a [flutter](https://flutter.dev/) application that allows a *sigle* user to *access*, *save*, *delete* and *edit* "shopping list items"\
across devices without real time synchronization,\
the application can be run and built for *android*, *ios*, *web* and *macos* and with partial features for *windows*, *linux* (see `known issues`),\
but please note that has been tested only for *android*, *web* and *linux*

## ARCHITECTURE

### ui

the app relies on [material design](https://material.io/design) with a few subdle animations,\
it also implements a splashscreen for *mobile* and *web* and launcher icon for *mobile*\

### ux

- ease of use
the expected use case is the user either *shopping* or quickly adding a memo,\
given the first scenario the app is designed to be easily operable with a sigle hand\
therefore the action of "checking" an item is achieved with a sigle swipe (ltr)\
while deleting an item requires a tap for confirm, \
while dimissing automatically being stuck in an unwanted state caused by accidental swipe (rtl)\

- speed
the app uses an "optimistic approach" for syncing data, the user will never have to wait for loading\
see technical details below\

### technical

the app is built with *clean code* and *domain driven design* in mind\
and implemented following the principles of *test driven development* (at the best of my capabilities)\
with a strictly enforced *minimium test coverage of 90%* by the custom [CI](https://github.com/iapicca/shopping_list/blob/master/.github/workflows/workflow.yml) running in [github actions](https://github.com/features/actions)\
here are some highlights:
- complete separation between *domain*, *logic* and *ui*
- ui completely synchronous
- "optimistic approach" for synchronization between logic and domain\
    all operation from ui take place instantly giving the user a feeling of "speed" regardless the actual speed connection\
    in case of failure from the backend the changes are reverted back to the previous state\
- minimal use of 3rd party packages
    besides development packages the only 3rd party packages are state management related: [hooks_riverpod](https://pub.dev/packages/hooks_riverpod) and [flutter_hooks](https://pub.dev/packages/flutter_hooks)

## RUN, TEST & BUILD

### SET UP

- [install flutter](https://flutter.dev/docs/get-started/install) 
    optional steps for [desktop support](https://flutter.dev/desktop)
    optional steps for web support: make sure [chrome](https://www.google.com/chrome) is installed 

- switch to `dev channel` running the following commands
```console
flutter channel dev
flutter upgrade -f
```

- make sure installation is succesful
    - run `flutter doctor -v` and make sure that setup is complete
    - make sure a virtual or physical device is attached and run the following commands
```console
flutter create counter_app
cd counter_app
flutter run
```

- clone this repository && cd on the repository location


### RUN THIS APP

- make sure a virtual or physical device is attached 

- run in `debug` mode using one of the following commands
    - mobile `flutter run` 
    - web `flutter run -d chrome`
    if desktop support has been enable during the setup
    - macos `flutter run -d macos`
    - linux `flutter run -d linux`
    - windows `flutter run -d linux`

- for a better evaluation of performances please use one of the following commands
    - mobile `flutter run --release` 
    - web `flutter run -d chrome --web-renderer canvaskit --release`

### TEST THIS APP

- run `flutter test`

### BUILD THIS APP

- to build for *android* run the command: `flutter build appbundle`
- to build for *web* run the command: `flutter build web --web-renderer canvaskit`

- for more comprehensive info please follow the official documentation
    [android](https://flutter.dev/docs/deployment/android)
    [ios](https://flutter.dev/docs/deployment/ios)
    [linux](https://flutter.dev/docs/deployment/linux)
    [web](https://flutter.dev/docs/deployment/web)

## known issues
- at the moment is not possible to check [connectivity](https://pub.dev/packages/connectivity) for *linux* and *windows* 
- [#7](https://github.com/iapicca/shopping_list/issues/7)





