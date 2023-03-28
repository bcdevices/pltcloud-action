# PLTcloud Action 

The PLTcloud action allows publishing firmware releases directly
to [BCD](https://www.bcdevices.com/)'s [PLTcloud](https://www.bcdevices.com/plt/) backend.
It allows you to upload a release to PLTcloud as part of your CI workflow.

## Input variables

Mandatory:

| input          | description                      |
| -------------- | -------------------------------- |
| `API_TOKEN`    | PLTcloud API token.              |
| `PROJECT_UUID` | Project id for PLTcloud project. |
| `FILES`        | List of files for upload. Files can be specified with patterns such as: `**/prefix*`, `grandparent/**/child?`, `**/parent/*`, or even just `**` |
| `VERSION`      | Release version. (default: `${{ github.ref }}`) |

Optional:

| input              | description                       |
| ------------------ | --------------------------------- |
| `VERBOSE`          | Verbose output (default: `false`) |
| `DEPLOYMENT_GROUP_UUID` | Deployment Group UUID |
| `AUTO_DEPLOY`      | Auto deploy release to PLT (default: `false`) |

## Usage

Step 1: Validate firmware build and test plans
==============================================

In order to upload a release, the PLT test plan, and any associated assets
such as DUT firmware must be available in a directory.

Setup a GitHub action to build the firmware and copy test plans
to a known directory.

Step 2: Configure project and token secrets
===========================================

- Log in to PLTcloud and select the `Project` menu item from the
  project drop-down in the top banner.
- Copy the ``UUID`` from the project detail page and a secret named
  ``PROJECT_UUID`` in your GitHub project.
- Select ``API Tokens`` from the drop-down menu under the user menu in PLTcloud
- Select ``Add Release Token``, login and copy the ``Release Upload Token``
- Add the release token to GitHub secrets and name it ``API_TOKEN``

Step 3: Add the PLTcloud action to the GitHub Actions Workflow
==============================================================

Add a step in the ``.github/workflows/main.yml`` actions workflow,
after the steps that build the firmware:

```yml
- uses: bcdevices/pltcloud-action@v1.1.4
  with:
    FILES: dist/*
    API_TOKEN: ${{ secrets.API_TOKEN }}
    PROJECT_UUID: ${{ secrets.PROJECT_UUID }}
    VERSION: ${{ github.ref }}
```

