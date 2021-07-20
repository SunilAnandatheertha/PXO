---
title: 'PXO (Poly-XTAL Operations): MATLAB Codebase to Generate, Analyse and Export Complex 2D Spatio-Temporally Gradient Grain Structures'
tags:
  - grain structure generation
  - texture and grain structure
authors:
  - name: Sunil Anandatheertha
    orcid: 0000-0001-6535-8191
    affiliation: "1"
affiliations:
 - name: Coventry University, Priory street, Coventry, United Kingdom, CV1 5FB
   index: 1
date: 07 January 2021
bibliography: paper.bib

---
# Statement of need
Mathematicians, statistical mechanists and computational material scientists are interested in studying the spatiotemporal evolutionary aspects of multi-classed partitioning of an n-dimensional space. Four examples for this are given and the statement of need is provided in each.

The 1st example is from mathematics. Here, researchers are interested in the chaotic partitioning of an n-D bounded spatial domain and its spatiotemporal evolution under some governing rules [@JMarkKlien1999]. A computational platform to study n-dimensional partitions of space is needed to enable this.

The 2nd example is from statistical mechanics. Here researchers are interested in importance sampling Monte-Carlo techniques studying the spatiotemporal evolution of the kinetics and thermodynamics of the distribution of multi-phase systems over some lattice. Though, exact solutions have been developed for the Ising model [@Baxter1989], it is however, impractical for more complex models like the Q-state Pott’s model, owing to the vastness of solution space. Here, a computational platform is needed to simulate such complex models which enables studying their complex behaviours.

The 3rd example is from fundamental computational materials science, where researchers are interested in the growth of grains [@Weaire1996]. Here the temporal evolution of spatial and thermodynamical parameters of multi-phase grain structures [@Anderson1984], [@Anderson1989] is studied at micro- and macro- scales. Though phase-field approaches are used, they are however, computational very intensive. Here, a computational platform is used to simulate grain growth in a simplified manner, and Monte-Carlo simulation techniques have been used to address this need [@Anderson1984]. A part of this research also touches upon understanding the kinematic and kinetic behaviour of grain structures in the presence of insoluble 2nd phase particles [@Srolovitz1984] and how they interact with the grain boundaries. Some of these studies have tried to validate empirical models of grain growth (for parameter such as grain growth exponent), and empirical models pertaining to grain structure geometry such as the Zener equation [@Manohar1998]. As the shape of the particles influences the Zener drag working against grain boundary evolution during grain growth [@Li1990], and also that, nature presents irregularly shaped particles, computer models which can consider such particle shape and their spatial distribution becomes very essential in computer simulations of grain growth. In addition to these, it is also important to understand the grain growth kinetics. A software platform is needed where such studies can be made.

The 4th example is from applied computational materials science. Here, researchers use techniques such as crystal plasticity based finite element analysis to study a material’s phase-partitioned thermo-mechanical response and texture evolution under applied thermo-mechanical loads [@Roters2010]. These are usually done at micro- and macro- scales. Computational material scientists studying multi-scale thermo-mechanical and texture behaviour of poly-crystalline materials need parametric and realistically tessellated geometric morphologies of the constituent phases reflected in the virtual grain structures. The virtual grain structures could be realized using experimentally derived grain structures or by developing a purely computer generated grain structures. Such grain structures are generally used in CPFEA [@YuhuiTu2021]. Though Voronoi tessellated geometries of grain structures have been used before, they are simplifications and do not accurately represent the geometric irregularities presented by nature. However, it is difficult to generate parametric, spatially gradient and physically realistic grain structures with multiple temporally-low-gradient slices. It is also difficult for many to acquire grain structures using experimental techniques like EBSD and even difficult to process them and use them numerically. Furthermore, such methods are also relevant to computational geology. A computer software program capable of preparing artificial and physically realistic grain structures for use in finite element analysis will be valuable.

# Summary
Poly-XTAL operations (`PXO`) is a MATLAB based computational platform which can enable users to create and prepare realistic grain structures for finite element analysis, simulate complex grain growth phenomenon and achieve spatiotemporal partitioning of a 2D space into a set of closed regions. In addition to various in-built tools, `PXO` generated grain structures can be imported into 3rd party open source libraries to tend to the specific requirements of the user. It allows easy inclusion of user defined physics based models for grain growth. Monte-Carlo simulations form the heart of `PXO`. However, Voronoi tessellation based grain structures can also be generated over different types of underlying lattices, with the added functionality of generating pixelated equivalent of Voronoi tessellation grain structures.

# Documentation
All documentation, tutorials and test cases may be accessed from [PXO/Wiki](https://github.com/SunilAnandatheertha/PXO/wiki).

# State of the field
Over the past few decades, MATLAB has emerged to be an easy-to-use, powerful and robust, high-level computational platform with ample documentation, and growing scientific and engineering community. Poly-XTAL Operations, written in MATLAB, offers the relevant research community, an added advantage over other programming software, as MATLAB has a flat to moderate learning curve. Options like MCPM [@JKMason2015], NEPER [@Quey2014] and DREAM3D [@MAGroeber2014] are available to model grain structures [@YuhuiTu2021]. Though, these are powerful environments to deal with grain structure calculations, researchers from a non-software background may find it hard to use and/or modify them to their specific requirements. Implementing user developed solver algorithms in `PXO` is easy. `PXO` offers the added advantage of being able to be linked with MTEX [@RHielscher2015] to deal with crystallographic texture calculations and advanced grain structure analysis. As `PXO` offers tools to export as many available temporal slices of grain structures as the user wishes, to a format able to be used in ABAQUS software for FEA, it offers a comparatively unique, viable and fast solution to researchers working in the field of Integrated Computational Materials Engineering (ICME) investigating structure-property-behaviour relationships. Additionally, `PXO` is able to combine this advantage with the ability to simulate grain growth in the presence of particles, particle clusters, fibres, whiskers and temperature fields. Another unique advantage is the capability of generating morphologically complex grain structure distributions.

# Example grain structures
![Example grain structures](Paper_images/example1.jpg)

The above figure shows some sample grain structures, which can be generated using `PXO`. [Tutorials](https://github.com/SunilAnandatheertha/PXO/wiki/Tutorials-and-test-cases) have been provided to help the users to getting started.

# Acknowledgements
The author acknowledges the computational resources offered by the following institutions: Indian Institute of Science during 2013-2014, PES University during 2014-2017 and Coventry University during 2017-2021. The author also acknowledges Dr. Kishore T Kashyap (Department of Mechanical Engineering, PES University, Bengaluru, India, in 2010) for his theoretical inputs on grain growth, Dr. G Narayana Naik (Department of Aerospace Engineering, Indian Institute of Science, Bengaluru, India) and Dr. N G Subramania Udupa (Nagarjuna College of Engineering and Technology, Bengaluru, India) for supervising the author’s master’s project in 2012-2014.

# References
