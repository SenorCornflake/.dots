from setuptools import setup

setup(
  name='neovim-command',
  #packages=['someprogram'],
  version='1.0.1',
  #author='...',
  #description='...',
  install_requires="pynvim",
  scripts=[
    'main.py',
  ],
  #entry_points={
  #  # example: file some_module.py -> function main
  #  #'console_scripts': ['someprogram=some_module:main']
  #},
)
