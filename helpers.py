"""Useful helpers."""
import os
import shutil
from invoke.exceptions import Failure


def npm_i(c, packages_to_install):
    """Install package via npm."""
    c.run("sudo npm install -g {0}".format(" ".join(packages_to_install)))


def yay(c, packages_to_install):
    """Install package via yay."""
    c.run("yay -Syu --nocleanmenu"
          " --nodiffmenu --noeditmenu"
          " --noupgrademenu --needed {0}".format(
              " ".join(packages_to_install)
          ))


def pacman_remove(c, packages_to_remove):
    """Remove unnecessary packages."""
    try:
        c.run("sudo pacman -Rscn {0}".format(" ".join(packages_to_remove)))
    except Failure:
        print("Packages might be removed.")


def makesl(what, where):
    """Just create symbol link."""
    # Normalize pathes
    what = os.path.abspath(what)
    where = os.path.abspath(where)

    if os.path.exists(what):
        if not os.path.exists(where):
            if os.path.islink(where):
                print("Broken link")
                os.remove(where)

            # Ensure parent exists
            if not os.path.exists(os.path.dirname(where)):
                os.makedirs(os.path.dirname(where))

            os.symlink(what, where)
            print("Created link {0} -> {1}".format(what, where))
        else:
            print("Link exists {0}".format(where))
    else:
        print("Source is not valid: {}".format(what))


def install_gitrepo(c, repo_url, where):
    """Install 1 depth level repo in the path overwriting the old."""
    where = os.path.abspath(where)

    # Dummy check
    if len(where) <= 10:
        raise Exception("Too small path to delete - {0} - {1}".format(len(where), where))

    if os.path.exists(where):
        if os.path.isdir(where):
            shutil.rmtree(where)

    c.run("git clone --depth 1 {0} {1}".format(repo_url, where))


def install_virtualenv(c, where, python="python3", pip_packages=None):
    """Install python virtualenv with packages."""
    where = os.path.abspath(where)

    # Dummy check
    if len(where) <= 10:
        raise Exception("Too small path to delete - {0} - {1}".format(len(where), where))

    if os.path.exists(where):
        if os.path.isdir(where):
            shutil.rmtree(where)

    os.makedirs(where)
    c.run("virtualenv -p {0} {1}".format(python, where))

    if pip_packages:
        c.run("{0}/bin/pip install --upgrade {1}".format(where, " ".join(pip_packages)))
