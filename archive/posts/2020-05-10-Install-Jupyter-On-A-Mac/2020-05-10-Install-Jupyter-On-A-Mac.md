---
layout: post
title: Install Jupyter Notebook on a Mac
hide_title: false
tags: [Python, Jupyter, MacOS]
excerpt: Install Jupyter Notebooks on a mac (Catalina) using homebrew
author: thecoolwinter
published: true
sitemap:
  lastmod: 2020-11-04
categories: snippets
---

I wish I had found out that jupyter notebooks was installable on a mac using homebrew earlier. After dealing with dual python installs and bad python paths, this solution seemed too easy.

## Homebrew

If you don't already have homebrew installed, insall it [here](https://docs.brew.sh/Installation).

Then, install jupyter notebooks using `brew install jupyter`



That's it. Wait for jupyter to install and you're done.

## Python

What's great about installing jupyter through homebrew is that it comes with it's own bundled version of python. That means jupyter will take care of dependencies, environments and anything else you might need in a normal python environment. All you have to do is use the python build that's installed with jupyter. The best way to find this is, well, using jupyter.

Start up a jupyter notebook using `jupyter notebook` in the terminal.

#### Dependencies

Then open your browser to the provided url and create a new notebook. I'm calling mine `dependencies` as this notebook will hold all the dependency installs I need.

In this new notebook I'm going to be installing `matplotlib` as a test.

```python
import sys
!{sys.executable} -m pip install matplotlib
```

Run that code in a cell in the notebook and let it install.

#### Python location

To find where python is located run `print(sys.executable)` in a jupyter cell after `import sys`. It'll print out the exact directory where jupyter's python is located.