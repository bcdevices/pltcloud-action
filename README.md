# pltcloud-action

The PLTcloud action allows publishing firmware releases directly
to BCD's PLTcloud backend.

## Usage

Step 1: Validate firmware build and test plans
==============================================

In order to upload a release, the PLT test plan, and any associated assets
such as DUT firmware must be available in a directory.

Setup a GitHub action to build the firmware and copy test plans
to a known directory.

Step 2: Configure project and token secrets
===========================================

- Log in to PLTcloud and select the `Project` menu item from the project drop-down in the top banner.
- Copy the ``UUID`` from the project detail page and a secret named ``PROJECT_UUID`` in your GitHub project.
- Select ``API Tokens`` from the drop-down menu under the user menu in PLTcloud
- Select ``Add Release Token``, login and copy the ``Release Upload Token``
- Add the release token to GitHub secrets and name it ``API_TOKEN``

Step 3: Add the PLTcloud action to the GitHub Actions Workflow
==============================================================


Add a step in the ``.github/workflows/main.yml`` actions firmware,
after the steps that build the firmware.

```
    - uses: .github/actions/action-pltcloud
      if: contains(github.ref, 'tags')
      env:
        API_TOKEN: ${{ secrets.API_TOKEN }}
        PROJECT_UUID: ${{ secrets.PROJECT_UUID }}
```


# License

The Dockerfile and associated scripts and documentation in this project are released under the [Apache 2.0 License](LICENSE).`
