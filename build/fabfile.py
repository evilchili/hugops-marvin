from fabric.api import task  # , env, cd

# import the fabric tasks and templates from cotton
import cotton.fabfile as cotton

# load application-specific settings from this module
cotton.set_fabric_env('cotton_settings')


@task
def init():
    """
    Initialize the app deployment
    """
    cotton.install()
    #cotton.create_project()
    cotton.install_iojs()

    cotton.upload_template_and_reload('defaults')

    # make a directory to hold the file-brain
    cotton.sudo("mkdir -p /var/hubot")
    cotton.sudo("chown marvin:marvin /var/hubot")


@task
def ship():
    """
    Deploy the current branch to production
    """
    cotton.git_push()
    cotton.install_iojs_dependencies()
