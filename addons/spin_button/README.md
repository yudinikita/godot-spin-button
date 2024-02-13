<p align="center">
   <img src="https://raw.githubusercontent.com/yudinikita/godot-spin-button/main/icon.png" alt="Godot Spin Button logo" width="150">
</p>

<h3 align="center">Spin Button</h3>

<p align="center">
  Horizontal Selector with extended options for Godot Engine 4.x.
  <br>
  <a href="https://godotengine.org/asset-library/asset/2454"><strong>Addon on Asset Library »</strong></a>
  <br>
  <br>
  <a href="https://github.com/yudinikita/godot-spin-button/wiki">Documentation</a>
  ·
  <a href="https://yudinikita.itch.io/godot-spin-button">Itch.io</a>
</p>

# Godot Spin Button

The addon adds a new "SpinButton" element that think of this thing as a dropdown but the navigation is managed by with next and previous controls. By incorporating this addon, users can conveniently choose options in a horizontal arrangement, thereby enhancing the overall user experience in Godot projects.

![Preview of Godot Spin Button](https://github.com/yudinikita/godot-spin-button/raw/main/images/readme_preview.png)

## ✨ Features

- **Modular Structure**: SpinButton has a modular structure and allows you to use only the necessary modules to make its size even smaller and the code clearer.

- **Rich API**: SpinButton comes with a very rich API. It allows creating your own pagination, navigation buttons, effects and many more.

- **Full Navigation Control**: SpinButton comes with all required built-in navigation elements, such as Pagination, Navigation arrows, Popup and Title with description.

- **Loop mode**: SpinButton has an option to loop through the options.

- **Popup**: SpinButton comes with a popup that opens when clicked, just like OptionButton.

- **Manipulation**: SpinButton has the ability to manipulate data using methods such as Append, Prepend, Add, Remove and Remove All.

- **Title & Description**: SpinButton comes with a title and description that can be displayed by events such as: hover, focus, always or never.

- **Keyboard control**: SpinButton allows you to control a value using the keyboard by triggering the specified event.

- **Mousewheel control**: SpinButton allows you to control the value with the mouse wheel.

- **Navigation**: SpinButton has "Previous" and "Next" buttons that allow you to change values.

- **Icons**: SpinButton comes with icons on the left and right that can display additional information

- **And many more...**

Slider, link, check, checkbox and custom button.

![Features of Godot Spin Button](https://github.com/yudinikita/godot-spin-button/raw/main/images/features.png)

## 📝 Getting started

### 1. Installation

There are few options on how to include/import SpinButton into your project:

#### Use SpinButton from Asset Library

If you want to include SpinButton files in your project, you may use it from Asset Library.

1. Open the AssetLib tab in the Godot editor.
2. Type the name of the addon "Spin Button" in the search bar.
3. Select the addon and click the **Download** button.

#### Install from GitHub

To start using the Spin Button addon in your project, follow these steps:

1. Clone or download the GodotSpinButton repository from GitHub:

```bash
git clone https://github.com/yudinikita/godot-spin-button.git
```

2. Copy the `godot-spin-button/addons/spin_button` folder inside your project's `addons` directory.
3. You're all set!

### 2. Usage

1. Enable the addon by going to `Project -> Project Settings -> Plugins` and activating the "Spin Button" plugin.
2. Add control on scene `Control -> BaseButton -> Button -> SBBaseButton -> SBButton`.
3. Customize or apply a theme for the button as you wish.

Happy coding!

## 📖 Documentation

Additional documentation is available in the [Wiki](https://github.com/yudinikita/godot-spin-button/wiki) section of the GitHub page. You can also refer to the embedded comments for a more detailed understanding of specific methods and functionality.

- [Home](https://github.com/yudinikita/godot-spin-button/wiki)
- [Core](https://github.com/yudinikita/godot-spin-button/wiki/Core)
  - [SBBaseButton](https://github.com/yudinikita/godot-spin-button/wiki/SBBaseButton)
  - [SBButton](https://github.com/yudinikita/godot-spin-button/wiki/SBButton)
- [Nodes](https://github.com/yudinikita/godot-spin-button/wiki/Nodes)
  - [SBSpinButton](https://github.com/yudinikita/godot-spin-button/wiki/SBSpinButton)
  - [SBSliderButton](https://github.com/yudinikita/godot-spin-button/wiki/SBSliderButton)
  - [SBLinkButton](https://github.com/yudinikita/godot-spin-button/wiki/SBLinkButton)
  - [SBCheckboxButton](https://github.com/yudinikita/godot-spin-button/wiki/SBCheckboxButton)
  - [SBCheckButton](https://github.com/yudinikita/godot-spin-button/wiki/SBCheckButton)
  - [SBCustomButton](https://github.com/yudinikita/godot-spin-button/wiki/SBCustomButton)
- [Modules](https://github.com/yudinikita/godot-spin-button/wiki/Modules)
  - [Navigation](https://github.com/yudinikita/godot-spin-button/wiki/Navigation)
  - [Pagination](https://github.com/yudinikita/godot-spin-button/wiki/Pagination)
  - [Manipulation](https://github.com/yudinikita/godot-spin-button/wiki/Manipulation)
  - [Keyboard Control](https://github.com/yudinikita/godot-spin-button/wiki/Keyboard-Control)
  - [Mousewheel Control](https://github.com/yudinikita/godot-spin-button/wiki/Mousewheel-Control)

## 🎨 Theme

With SpinButton, you can replicate a theme from many major AAA games or you can create your own unique theme.

![Theme of Godot Spin Button](https://github.com/yudinikita/godot-spin-button/raw/main/images/theme.png)

> Creating a theme has its own peculiarities, so read the documentation on this topic to better understand how to create a theme for SpinButton.

- [How to create a theme](https://github.com/yudinikita/godot-spin-button/wiki/How-to-create-a-theme)
- [Theme Module](https://github.com/yudinikita/godot-spin-button/wiki/Theme-module)

## 📚 Project Architecture

Here is an overview of the project's file hierarchy:

```
godot-spin-button/
`-- addons/
    `-- spin_button/
        `-- src/
            |-- core/
            |   |-- base_button
            |   `-- button
            |-- components
            |-- controls
            `-- modules
```

The addon has a clear structure, which is demonstrated for each button in the corresponding tab of the example.

![Structure of Godot Spin Button](https://github.com/yudinikita/godot-spin-button/raw/main/images/structure.png)

Here is an overview of the button hierarchy:

```
SpinButton/
`-- Wrapper/
    `-- Container/
        |-- LeftIcon
        |-- TitleWrapper/
        |   `-- TitleButton/
        |       `-- TitleContainer/
        |           |-- TitleLabel
        |           `-- DescriptionLabel
        |-- ContentWrapper/
        |   `-- ContentButton/
        |       `-- ContentContainer/
        |           |-- PrevWrapper/
        |           |   `-- PrevButton
        |           |-- ValueWrapper/
        |           |   `-- ValueButton/
        |           |       |-- ValueText/
        |           |       |   `-- ValueLabel
        |           |       `-- BulletsWrapper
        |           `-- NextWrapper/
        |               `-- NextButton
        `-- RightIcon
```

## ❓ FAQ

Here you will find the most frequently asked questions relating to the project answered. See [FAQ](https://github.com/yudinikita/godot-spin-button/wiki/FAQ) for more information.

## 💬 Note

If you have any suggestions or encounter any problems when using the app, please feel free to contact us by email. I am ready to help you and solve any of your problems.

## 🔐 License

The source code of this project is licensed under the MIT license, which can be found [here](LICENSE).

---

> Site [yudinikita.ru](https://yudinikita.ru) &nbsp;&middot;&nbsp;
> Email <mail@yudinikita.ru> &nbsp;&middot;&nbsp;
> GitHub [@yudinikita](https://github.com/yudinikita)
