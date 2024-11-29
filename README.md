# okteto-public-api-samples
This repository show some samples on how to use the Okteto's public API in combination with other tools to automate operations

All the samples expect you have a couple of environment variables set:
* OKTETO_URL: It is the URL of your Okteto instance. For example: https://test.okteto.com/
* OKTETO_TOKEN: It is the token to authenticate against the Okteto API, and it will be also used by the CLI in those scripts that use it. You can create an Admin Access Token from the Okteto UI.

Those environment variables are used to contact to the public API, but also by the Okteto CLI, so it is not needed to execute `okteto context use` before running the scripts.

## Samples

### Sleep all development namespaces

`sleep-all-namespace.sh` retrieves all the development namespaces (no previews) in the Okteto instance and puts them to sleep, skipping the ones already sleeping or persistent. This is useful to save resources when you are not using them.

Example of usage:

```bash
$ OKTETO_URL=https://test.okteto.com/ OKTETO_TOKEN=your-token ./sleep-all-namespace.sh
```

### Sleep all preview namespaces

`sleep-all-previews.sh`, similarly to what the previous one does, it retrieves all the preview namespaces in the Okteto instance and puts them to sleep, skipping the ones already sleeping or persistent. This is useful to save resources when you are not using them.

Example of usage:

```bash
$ OKTETO_URL=https://test.okteto.com/ OKTETO_TOKEN=your-token ./sleep-all-previews.sh
```

### List all applications within all the development namespaces

`list-all-applications.sh` retrieves all the development namespaces (no previews) in the Okteto instance, and lists all the applications within them including the repository from where they are deployed (if any). This is useful to know what is running in your instance.

Example of usage:

```bash
$ OKTETO_URL=https://test.okteto.com/ OKTETO_TOKEN=your-token ./list-applications-within-envs.sh
```

### Delete dev volumes on development namespaces

`delete-dev-volumes.sh` checks which dev volumes (the ones created by Okteto when you run `okteto up`) are not being used by any pod in any development namespace, and deletes them. This is useful to save resources when you are not using them.

Example of usage:

```bash
$ OKTETO_URL=https://test.okteto.com/ OKTETO_TOKEN=your-token ./delete-dev-volumes.sh
```

### Redeploy an application within any development namespace

`redeploy-app.sh` allows to redeploy a specific application on any development namespace to keep it up to date. This script expects a repository in the form of <owner>/repo (e.g. `okteto/movies`), and it might also accept a branch. 
It will check all applications deployed within all the development namespaces, and it will redeploy all the ones that match the repository and branch provided. If branch is not provided, it will only match the repository.

> **Note**: This scripts uses gdate to calculate the time, so you might need to install it if you are using MacOS. You can install it with `brew install coreutils`.

Example of usage:

```bash
$ OKTETO_URL=https://test.okteto.com/ OKTETO_TOKEN=your-token ./redeploy-app.sh okteto/movies
```