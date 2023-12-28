<p align="center">
   <img src="https://raw.githubusercontent.com/nblackninja/godot-spin-button/main/icon.png" alt="Godot Spin Button logo" width="150">
</p>

<h3 align="center">Spin Button</h3>

<p align="center">
  Horizontal Selector with extended options for Godot Engine 4.x.
  <br>
  <a href="https://godotengine.org/asset-library/asset/2454"><strong>Addon on Asset Library »</strong></a>
</p>

# Godot Spin Button

The addon adds a new "SpinButton" element that think of this thing as a dropdown but the navigation is managed by with next and previous controls. By incorporating this addon, users can conveniently choose options in a horizontal arrangement, thereby enhancing the overall user experience in Godot projects.

![Preview of Godot Spin Button](images/readme_preview.png)

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

![Features of Godot Spin Button](images/features.png)

## 📝 Getting started

### 1. Installation

1. Download the repository.
2. Clone the new repository locally.
3. Copy the `addons/spin_button` folder inside your project's `addons` directory.
4. You're all set!

### 2. Usage

1. Enable the addon by going to `Project -> Project Settings -> Plugins` and activating the "Spin Button" plugin.
2. Add control on scene `Control -> BaseButton -> Button -> SBBaseButton -> SBButton`.
3. Customize or apply a theme for the button as you wish.

Happy coding!

## 🎨 Theme

With SpinButton, you can replicate a theme from many major AAA games or you can create your own unique theme.

![Theme of Godot Spin Button](images/theme.png)

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

![Structure of Godot Spin Button](images/structure.png)

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

## 💬 Note

If you have any suggestions or encounter any problems when using the app, please feel free to contact us by email. I am ready to help you and solve any of your problems.

## 🔐 License

The source code of this project is licensed under the MIT license, which can be found [here](LICENSE).

---

> <nikitayudin782@gmail.com> &nbsp;&middot;&nbsp;
> GitHub [@nblackninja](https://github.com/с) &nbsp;&middot;&nbsp;
> Telegram [@yudinikita](https://t.me/yudinikita)
