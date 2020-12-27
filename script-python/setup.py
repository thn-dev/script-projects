from setuptools import find_packages, setup

setup (
    name='<name>',
    version='<version>',
    platforms=["any"],
    license='<(c) YYYY - blahblah>',
    long_description='<description>',
    packages=find_packages(exclude=["<package name>", "<directory name>", "test"]),
)
