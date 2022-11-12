# Send a personalized email to every recipient in recipients.csv
#
# Format of recipients.csv:
# Name, Email
import csv
import re
from collections import namedtuple
from subprocess import Popen, PIPE

from pipe import *

EmailTemplate = namedtuple("EmailTemplate", "subject body_template")
Recipient = namedtuple("Recipient", "name email_address")


def generate_email_and_open_in_mailmate(to_address, subject, body, from_address):
    p = Popen(["emate",
               "mailto",
               f"-f {from_address}",
               f"-t {to_address}",
               f"-s {subject}",
               "--header", "#markup: markdown"],
              stdin=PIPE)
    p.communicate(input=body.encode("utf8"))
    p.wait()


def generate_emails_and_open_in_mailmate(from_address, recipients, email_template):
    for recipient in recipients:
        body = re.sub("{name}", recipient.name, email_template.body_template, flags=re.MULTILINE)
        generate_email_and_open_in_mailmate(recipient.email_address, email_template.subject, body, from_address)


def parse_recipients_csv(filename, encoding):
    with open(filename, encoding=encoding) as csvfile:
        recipients_reader = csv.DictReader(csvfile, delimiter=',')

        return list(recipients_reader
                    | select(lambda row: Recipient(row["name"], row["email_address"])))


def read_mail_template(filename, encoding):
    with open(filename, encoding=encoding) as f:
        result = f.read()

    return result


def parse_email_template(filename, encoding):
    email_template_file = read_mail_template(filename, encoding)
    matches = re.match(r"^# (?P<subject>.*)$", email_template_file, flags=re.MULTILINE)

    subject = matches.group("subject")
    body_template = email_template_file.replace(f"# {subject}", "")
    body_template = body_template.strip()

    return EmailTemplate(subject, body_template)


if __name__ == '__main__':
    email_template = parse_email_template("email_template.md", "utf8")
    recipients = parse_recipients_csv("recipients.csv", "utf8")

    from_address = "The YASCR22 Code Retreat Organizers <yascr22@boos.systems>"
    generate_emails_and_open_in_mailmate(from_address, recipients, email_template)
