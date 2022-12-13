# YASCR22

## What is YASCR22?

YASCR22 is a **remote code retreat**, organized and facilitated by members of the [Small Coding Dojo](https://github.com/small-coding-dojo/) organization.

This particular retreat will **focus more on practicing** and less on teaching.

The topic will be **refactoring**.

You can find more about code retreats in general at the [Code Retreat](https://www.coderetreat.org/the-workshop/) website.

## Schedule for Nov. 30, 2022

### Overview

| Start | Activity |
| --- | --- |
| 08:45 | Open doors, prepare avatars on the miro board |
| 09:00 | Check technical setup, welcome, wait for everyone to "arrive" |
| 09:15 | Presentation of the exercise(s) |
| 09:30 | Distributing the tools (containers, IDEs, rooms, miro, etc.) |
| 09:45 | (2:45h) Topic 1 - 2 sessions |
| 12:30 | Lunch (maybe [Lunch & Learn](https://www.indeed.com/career-advice/career-development/brown-bag-lunch) style) |
| 13:30 | (3h) Topic 2 - 2 Sessions |
| 16:30 | Reflection, revision and exchange of the whole group |
| 17:15 | Good Bye |

### Schedule for Each Session

| 1h 25' | 1h 35' | Activity
| -- | --- | --- |
|  5' |  5' | Every session starts with new groups |
| 10' | 10' | Exercise clarification |
| 40' | 45' | Practicing a kata (this is were we have technical dialogues) |
|  5' | 10' | Reflecting in the small group -> decide what to share with all |
| 15' | 15' | Reflecting together |
| 15' | 15' | Break |

## Other Preparation Materials

- [Shared Folder in NextCloud](https://oc.serv4us.de/f/102382) - This is an internal link for the organizers.
- [JetBrains Projector](JetBrains-Projector.md) - Describes our JetBrains Projector setup.
- [scripts](scripts) - Automates our JetBrains Projector setup.

## Technical Preparation for Workshop Facilitators

This section describes the technical prerequisites **for workshop facilitators**. Participants only need a recent web
browser.

During the code retreat the participants will use a JetBrains IDE from a web browser. This IDE will be preconfigured:

- It will open a clone of the GitHub repository used during the workshop.
- It can pull from and push to that repository.
- Each commit is associated with the IDE instance name - there is no additional setup required for participants.

### Prerequisite: `gcloud` Command Line Tool

Multiple JetBrains IDEs run in associated
[JetBrains Projector Docker Containers](https://github.com/JetBrains/projector-docker) on
[Google CloudRun](https://console.cloud.google.com/run)

To be able to start and stop the deployment, facilitators need to
[install the gcloud CLI](https://cloud.google.com/sdk/docs/install) for their operating system. The
[gcloud beta](https://cloud.google.com/sdk/gcloud/reference/beta) commands need to be installed together
with (or after) the CLI:

```shell
gcloud components install beta
```

### Launching the Projector Instances

The facilitators share ownership of the
[Google Cloud project YASCR](https://console.cloud.google.com/welcome?project=yascr-365610).

To give new facilitators the required permissions, navigate to the
[IAM management](https://console.cloud.google.com/iam-admin/iam?project=yascr-365610) pane and invite them using their
Google account email address. Associate them with the **Owner** role.

If not done already, facilitators need to authenticate their `gcloud` cli with their Google account:

```shell
gcloud init
```

Invoking the command later again would allow to change the default project for the `gcloud` cli. For YASCR this is
not needed, because the scripts specify the project via the `--project` argument.

### Updating the Projector Docker Images

We maintain a Dockerfile derived from the original
[JetBrains Projector Docker image](https://github.com/JetBrains/projector-docker) in the [docker](./docker) directory.
Rebuilding the image requires the following:

- Place a **private** SSH key with name `id_yascr22` into your local working directory `.../docker/.ssh/id_yascr22`.
  This private key must match the public key registered with the GitHub repository
- Configure your local Docker with the gcloud repository: `gcloud auth configure-docker europe-west1-docker.pkg.dev`
- Verify the configuration: `echo "europe-west1-docker.pkg.dev" | docker-credential-gcloud get`

To build and push the Docker image:

```shell
cd docker
docker build -t "europe-west1-docker.pkg.dev/yascr-365610/docker-repository/projector-idea-c:latest" .
docker push europe-west1-docker.pkg.dev/yascr-365610/docker-repository/projector-idea-c:latest
```

## Links and References

- [CodeRetreat.org - The Workshop](https://www.coderetreat.org/the-workshop/)
- [Code Retreat Facilitation Guide](https://www.coderetreat.org/facilitators/facilitation/)
