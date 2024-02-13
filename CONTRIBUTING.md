# Contributing to Godot Spin Button

First off, thanks for taking the time to contribute! ❤️

All types of contributions are encouraged and valued. See the [Table of Contents](#table-of-contents) for different ways to help and details about how this project handles them. Please make sure to read the relevant section before making your contribution. It will make it a lot easier for us maintainers and smooth out the experience for all involved. The community looks forward to your contributions. 🎉

> And if you like the project, but just don't have time to contribute, that's fine. There are other easy ways to support the project and show your appreciation, which we would also be very happy about:
> - Star the project
> - Tweet about it
> - Refer this project in your project's readme
> - Mention the project at local meetups and tell your friends/colleagues

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [I Have a Question](#i-have-a-question)
- [I Want To Contribute](#i-want-to-contribute)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Enhancements](#suggesting-enhancements)
- [Your First Code Contribution](#your-first-code-contribution)
- [Improving The Documentation](#improving-the-documentation)
- [Styleguides](#styleguides)
- [Commit Messages](#commit-messages)
- [Join The Project Team](#join-the-project-team)

## Code of Conduct

This project and everyone participating in it is governed by the
[Godot Spin Button Code of Conduct](https://github.com/yudinikita/godot-spin-button/blob/master/CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report unacceptable behavior
to .

## I Have a Question

> If you want to ask a question, we assume that you have read the available [Documentation](https://github.com/yudinikita/godot-spin-button/wiki).

Before you ask a question, it is best to search for existing [Issues](https://github.com/yudinikita/godot-spin-button//issues) that might help you. In case you have found a suitable issue and still need clarification, you can write your question in this issue. It is also advisable to search the internet for answers first.

If you then still feel the need to ask a question and need clarification, we recommend the following:

- Open an [Issue](https://github.com/yudinikita/godot-spin-button//issues/new).
- Provide as much context as you can about what you're running into.
- Provide project and platform versions (godot, addon, etc), depending on what seems relevant.

We will then take care of the issue as soon as possible.

## I Want To Contribute

> ### Legal Notice
> When contributing to this project, you must agree that you have authored 100% of the content, that you have the necessary rights to the content and that the content you contribute may be provided under the project license.

### Reporting Bugs

#### Before Submitting a Bug Report

A good bug report shouldn't leave others needing to chase you up for more information. Therefore, we ask you to investigate carefully, collect information and describe the issue in detail in your report. Please complete the following steps in advance to help us fix any potential bug as fast as possible.

- Make sure that you are using the latest version.
- Determine if your bug is really a bug and not an error on your side e.g. using incompatible environment components/versions (Make sure that you have read the [documentation](https://github.com/yudinikita/godot-spin-button/wiki). If you are looking for support, you might want to check [this section](#i-have-a-question)).
- To see if other users have experienced (and potentially already solved) the same issue you are having, check if there is not already a bug report existing for your bug or error in the [bug tracker](https://github.com/yudinikita/godot-spin-button/issues?q=label%3Abug).
- Also make sure to search the internet (including Stack Overflow) to see if users outside of the GitHub community have discussed the issue.
- Collect information about the bug:
- Stack trace (Traceback)
- OS, Platform and Version (Windows, Linux, macOS, x86, ARM)
- Version of the interpreter, compiler, SDK, runtime environment, package manager, depending on what seems relevant.
- Possibly your input and the output
- Can you reliably reproduce the issue? And can you also reproduce it with older versions?

#### How Do I Submit a Good Bug Report?

> You must never report security related issues, vulnerabilities or bugs including sensitive information to the issue tracker, or elsewhere in public. Instead sensitive bugs must be sent by email to .

We use GitHub issues to track bugs and errors. If you run into an issue with the project:

- Open an [Issue](https://github.com/yudinikita/godot-spin-button//issues/new). (Since we can't be sure at this point whether it is a bug or not, we ask you not to talk about a bug yet and not to label the issue.)
- Explain the behavior you would expect and the actual behavior.
- Please provide as much context as possible and describe the *reproduction steps* that someone else can follow to recreate the issue on their own. This usually includes your code. For good bug reports you should isolate the problem and create a reduced test case.
- Provide the information you collected in the previous section.

Once it's filed:

- The project team will label the issue accordingly.
- A team member will try to reproduce the issue with your provided steps. If there are no reproduction steps or no obvious way to reproduce the issue, the team will ask you for those steps and mark the issue as `needs-repro`. Bugs with the `needs-repro` tag will not be addressed until they are reproduced.
- If the team is able to reproduce the issue, it will be marked `needs-fix`, as well as possibly other tags (such as `critical`), and the issue will be left to be [implemented by someone](#your-first-code-contribution).

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for Godot Spin Button, **including completely new features and minor improvements to existing functionality**. Following these guidelines will help maintainers and the community to understand your suggestion and find related suggestions.

#### Before Submitting an Enhancement

- Make sure that you are using the latest version.
- Read the [documentation](https://github.com/yudinikita/godot-spin-button/wiki) carefully and find out if the functionality is already covered, maybe by an individual configuration.
- Perform a [search](https://github.com/yudinikita/godot-spin-button//issues) to see if the enhancement has already been suggested. If it has, add a comment to the existing issue instead of opening a new one.
- Find out whether your idea fits with the scope and aims of the project. It's up to you to make a strong case to convince the project's developers of the merits of this feature. Keep in mind that we want features that will be useful to the majority of our users and not just a small subset. If you're just targeting a minority of users, consider writing an add-on/plugin library.

#### How Do I Submit a Good Enhancement Suggestion?

Enhancement suggestions are tracked as [GitHub issues](https://github.com/yudinikita/godot-spin-button//issues).

- Use a **clear and descriptive title** for the issue to identify the suggestion.
- Provide a **step-by-step description of the suggested enhancement** in as many details as possible.
- **Describe the current behavior** and **explain which behavior you expected to see instead** and why. At this point you can also tell which alternatives do not work for you.
- You may want to **include screenshots and animated GIFs** which help you demonstrate the steps or point out the part which the suggestion is related to. You can use [this tool](https://www.cockos.com/licecap/) to record GIFs on macOS and Windows, and [this tool](https://github.com/colinkeenan/silentcast) or [this tool](https://github.com/GNOME/byzanz) on Linux.
- **Explain why this enhancement would be useful** to most Godot Spin Button users. You may also want to point out the other projects that solved it better and which could serve as inspiration.

### Your First Code Contribution

#### Setup

1. **Fork the Repository**: Start by forking the Godot Spin Button GitHub repository to your own GitHub account.
2. **Clone the Repository**: Clone your fork locally on your machine.

    ```bash
    git clone https://github.com/yudinikita/godot-spin-button.git
    ```

3. **Set Upstream**: Add the original repository as an upstream remote.

    ```bash
    git remote add upstream https://github.com/yudinikita/godot-spin-button.git
    ```

#### Getting Started

1. **Create a Feature Branch**: Any new feature or bugfix should be developed in a separate branch.

    ```bash
    git checkout -b feature/your-feature-name develop
    ```

2. **Commit Your Changes**: Make your changes and commit them.

    ```bash
    git add .
    git commit -m "Implemented feature X"
    ```

3. **Push and Create a Pull Request**: Push your changes to your fork and create a pull request from there to the original repository.

    ```bash
    git push origin feature/your-feature-name
    ```

### Improving The Documentation

To update, improve, and correct the documentation, you can follow these steps:

1. Review the existing documentation and identify areas that need updating, improvement, or correction.
2. Make the necessary changes to the documentation, ensuring that the information is accurate, clear, and up-to-date.
3. Update any code examples or diagrams to reflect the current state of the project.
4. Proofread the documentation to check for any spelling or grammatical errors.
5. Test the documentation to ensure that the instructions and explanations are accurate and easy to follow.
6. Publish the updated documentation so that it is easily accessible to users.

By following these steps, you can ensure that your documentation is regularly updated, improved, and corrected to provide the best possible support to your users.

## Styleguides

### Commit Messages

Commit messages play an important role in maintaining a clean and organized codebase. They provide a concise summary of the changes made in a commit, making it easier for other developers to understand the purpose and context of the changes.

When writing commit messages, it is recommended to follow the [Conventional Commits](https://www.conventionalcommits.org/) format. This format provides a standardized way of structuring commit messages, making it easier to generate changelogs and perform automated tasks based on commit history.

By using [Conventional Commits](https://www.conventionalcommits.org/) , you can ensure that your commit messages are clear, descriptive, and easy to understand. This improves collaboration among team members and helps maintain a high level of code quality.

Remember to include a concise subject line that summarizes the change, followed by a more detailed description (if necessary). Additionally, you can use commit message prefixes to indicate the type of change (e.g., feat, fix, chore, etc.).

By adhering to the Conventional Commits format, you can make the commit history more meaningful and informative, ultimately improving the overall development process.

## Join The Project Team

Are you passionate about coding and want to contribute to an exciting project? Join our project team and be part of a collaborative and innovative development environment.

We are looking for talented individuals who have experience with godot and game development and are eager to work on Godot Spin Button. As a member of our project team, you will have the opportunity to help us improve the project.

To join our team, please send your resume and portfolio to <mail@yudinikita.ru>. We look forward to hearing from you and working together to create something amazing!

## Attribution

This guide is based on the **contributing-gen**. [Make your own](https://github.com/bttger/contributing-gen)!
