# Scripts to Deploy of JetBrains Projector on Google Cloud Run

The scripts in this folder automate the deployment described in our [JetBrains
Projector](../JetBrains-Projector.md) documentation.

Before using the scripts, please configure the "projector" by commenting and
uncommenting the proper variables in [.env](.env).

## Control Scripts

The following scripts are used to deploy and delete projector images in Cloud
Run:

- [deploy-services.sh](deploy-services.sh) - deploy the configured number of JetBrains Projector images.
- [delete-services.sh](delete-services.sh) - delete all running projector* images.
- [disable-shutdown-when-idle.sh](disable-shutdown-when-idle.sh) - prevent containers from shutting down when idle.
- [enable-shutdown-when-idle.sh](enable-shutdown-when-idle.sh) - allow containers auto-shut-down after 15 minutes idle.

## Deployment Aspects

### Keep Containers Active When Idle

#### Problem: Auto-Shut-Down of Idle Projector Containers

By default, CloudRun shuts idle projector containers down after 15 minutes.
As a consequence, users have to re-configure Rider.

#### Solution: Disable Auto-Shut-Down in CloudRun Configuration

Deploying containers using the flags `--no-cpu-throttling` and `--min-instances 1`
we prevent the automatic shut down.

Details about configuring the CloudRun deployment are explained in the associated
[CPU allocation (services) documentation](https://cloud.google.com/run/docs/configuring/cpu-allocation?hl=en).

#### Caveat: Changing the CloudRun Service Configuration Results in Re-Deployment

Caveat: Changing the configuration of a CloudRun deployment results in a re-deployment.
After a configuration change, e.g. by using the `enable-...` and `disable...` scripts,
you have a fresh container instance and need to configure Rider and the project again.

#### Test the Default Deployment and Enable/Disable-... Scripts

Links for the checks required in the Gherkin `THEN` paragraphs below:

- [Google CloudRun Service Configuration Page for Projector-Rider-2](https://console.cloud.google.com/run/deploy/europe-west1/projector-rider-2?project=yascr-365610)
- [Google CloudRun Metrics for Projector-Rider-2](https://console.cloud.google.com/run/detail/europe-west1/projector-rider-2/metrics?project=yascr-365610)

```gherkin
SCENARIO 1: Default Deployment with Always-On
GIVEN normal deployment of 2 projector-rider instances 
AND the projector configuration is completed for projector-rider-2
AND > 15 minutes passed without interaction

WHEN I reload the projector-rider-2 browser page using the same URL

THEN the state of projector-rider-2 is the same as before the reload,
i.e. I don't need to configure the IDE again
AND the service configuration page for projector-rider-2 shows:
    `CPU is always allocated`, `Minimum number of instances 1`, `Maximum number of instances 1`
AND metrics show that the `projector-rider-2` has been billable for the entire period of time
```

```gherkin
SCENARIO 2: Enable Auto-Shutdown
GIVEN normal deployment of 2 projector-rider instances
WHEN I execute the enable-... script
AND I complete the projector configuration for projector-rider-2
AND I wait for > 15 minutes without interaction
AND I reload the projector-rider-2 browser page using the same URL

THEN the state of projector-rider-2 differs from before the reload,
i.e. I need to configure the IDE again
AND the service configuration page for projector-rider-2 shows:
    `CPU is only allocated during request processing`, `Minimum number of instances 0`, `Maximum number of instances 1`
AND metrics show that the `projector-rider-2` has NOT been billable for the entire period of time
```

```gherkin
SCENARIO 3: Disable Auto-Shutdown
GIVEN normal deployment of 2 projector-rider instances
AND I have executed the enable-... script

WHEN I execute the disable-... script
AND I complete the projector configuration for projector-rider-2
AND I wait for > 15 minutes without interaction
AND I reload the projector-rider-2 browser page using the same URL

THEN the state of projector-rider-2 is the same as before the reload,
i.e. I don't need to configure the IDE again
AND the service configuration page for projector-rider-2 shows:
    `CPU is always allocated`, `Minimum number of instances 1`, `Maximum number of instances 1`
AND metrics show that the `projector-rider-2` has been billable for the entire period of time
```

Note:

The specifications explicitly take metrics from projector-rider-2 in order to prevent an error in looping through all
configured instances. I have not considered edge cases in the tests (i.e. test the last instance,
test the first instance, etc.), because of time and quite low risk - assuming that we will not change the
code structure of the scripts!

## Helper Scripts

The following script is called by the control scripts described above:

- [read-env.sh](read-env.sh) - Source the [.env](.env) configuration file.
