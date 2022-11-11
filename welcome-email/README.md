# Serial Email Generator

Generate serial emails from a markdown template and a recipients list.

## Overview

This python3 application generates one email per entry in the `recipients.csv` file. Each email is
constructed from the markdown template [welcome_email.md](./welcome_email.md). The application replaces the `{name}`
expression in the template by each recipient name taken from the csv file. It passes each email to
[MailMate](https://freron.com/) using the [emate](https://manual.mailmate-app.com/emate) cli tool shipped with
[MailMate](https://freron.com/).

## Status: Proof of Concept

This application is considered a "Proof of Concept (PoC)". It does not come with tests and has been constructed using
trial and error. Use at your own risk and inspect the constructed Emails carefully before sending. We plan to rewrite
the application before adding features.

## Caveat: Never Commit Personal Data

To prevent publishing personal data like email addresses by accident, the `recipients.csv` file is listed in
[.gitignore](./.gitignore).

Never commit personal data!

For test purposes, a file `recipients.csv` with the following data can be created in the current directory:

```csv
name,email_address
John Doe,jdoe@example.com
Jane Doe,jane@example.com
Mr. Johnson,johnson@example.com
Herr Schmitt,schmitt@example.com
```

## Prerequisites

- [MailMate](https://freron.com/)
- [Python](https://www.python.org/) >= 3.3

## Running the Application

Create the `recipients.csv` file as described above. Then run

```shell
# First time prerequisites
pip install requirements.txt

# Run
python3 main.py
```

This will open MailMate and show all generated emails in individual windows.
