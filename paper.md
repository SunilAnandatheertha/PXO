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
Mathematicians, statistical mechanists and computational materials scientists are interested in studying the spatiotemporal evolutionary aspects of multi-classed partitioning of an n-dimensional space. Four examples for this are given and the statement of need is provided in each.

The 1st example is from mathematics. Here, researchers are interested in the chaotic partitioning of an n-D bounded spatial domain and its spatiotemporal evolution under some governing rules [@JMarkKlien1999]. A computational platform to study n-dimensional partitions of space is needed to enable this.

The 2nd example is from statistical mechanics. Here researchers are interested in importance sampling Monte-Carlo techniques studying the spatiotemporal evolution of the kinetics and thermodynamics of the distribution of multi-phase systems over some lattice. Though, exact solutions have been developed for Ising model [@Baxter1989], it is however, impractical for more complex models like the Q-state Pott’s model, owing to the vastness of solution space. Here, a computational platform is needed to simulate such complex models which enables studying their complex behaviours.

The 3rd example is from fundamental computational materials science, where researchers are interested in the growth of grains [@Weaire1996]. Here the temporal evolution of spatial and thermodynamical parameters of multi-phase grain structures [@Anderson1984], [@Anderson1989] is studied at micro- and macro- scales. Though phase-field approaches are used, they are however, computational very intensive. Here, a computational platform is used to simulate grain growth over a simplified manner, and Monte-Carlo simulation techniques have been used to address this need [@Anderson1984]. A part of this research also touches upon understanding the kinematic and kinetic behaviour of grain structures in the presence of insoluble 2nd phase particles [@Srolovitz1984] and how they interact with the grain boundaries. Some of these studies have tried to validate emperical models of grain growth (for parameter such as grain growth exponent), and empirical models pertaining to grain structure geometry such as the Zener equation [@Manohar1998]. As the shape of the particles influences the Zener drag working against grain boundary evolution during grain growth [@Li1990], and also that, nature presents irregularly shaped particles, computer models which can consider such particle shape and their spatial distribution becomes very essential in computer simulations of grain growth. In addition to these, it is also important to understand the grain growth kinetics. A software platform is needed where such studies can be made.

The 4th example is from applied computational materials science. Here, researchers use techniques such as crystal plasticity based finite element analysis (CPFEA) to study material’s phase-partitioned thermo-mechanical response and texture evolution under applied thermo-mechanical loads [@Roters2010]. These are usually done at micro- and macro- scales. Computational materials scientists studying multi-scale thermo-mechanical and texture behaviour of poly-crystalline materials need parametric and realistically tessellated geometric morphologies of the constituent phases reflected in the virtual grain structure. The virtual grain structures could be realized using experimentally derived grain structures or by developing a purely computer generated grain structure. Such grain structures are generally used in CPFEA [@YuhuiTu2021]. Though Voronoi tessellated geometries of grain structures have been used before, they are simplifications and do not accurately represent the geometric irregularities presented by nature. However, it is difficult to generate parametric spatially gradient physically realistic grain structures with multiple temporally-low-gradient slices. It is also difficult for many to acquire grain structures using experimental techniques like EBSD and even difficult to process them and use them numerically. Similar needs are also believed to be present in computational geology. A computer software program capable of preparing artificial and physically realistic grain structures for use in FEA will be valuable.

# Summary
Poly-XTAL operations ('PXO') is a MATLAB based computational platform which can enable users to create and prepare realistic grain structures for finite element analysis, simulate complex grain growth phenomenon and achieve spatiotemporal partitioning of a 2D space into a set of closed regions. In addition to various in-built tools, 'PXO' generated grain structure can be imported into 3rd party open source libraries to tend to the specific requirements of the user. It allows easy inclusion of user defined physics based models for grain growth. Monte-Carlo simulations (MCS) form the heart of PXO. However, Voronoi tessellation (VT) based grain structures can also be generated over different types of underlying lattices, with the added functionality of generating pixelated equivalent of VT grain structure.

# Documentations
All documentations, tutorials and test cases may be accessed from [PXO/Wiki](https://github.com/SunilAnandatheertha/PXO/wiki).

# State of the field
Over the past few decades, MATLAB has emerged to be an easy to use, powerful and robust, high-level computational platform with ample documentation and growing scientific and engineering community. Poly-XTAL Operations, written in MATLAB, offers the relavant research community, an added advantage over other programming softwares, as MATLAB has a flat to moderate learning curve. Options like MCPM [@JKMason2015], NEPER [@Quey2014] and DREAM3D [@MAGroeber2014] are available to model grain structure [@YuhuiTu2021]. Though, these are powerfull environments to deal with grain structure calculations, researchers from a non-software background may find it hard to use and/or modify them to their specific requirements. Implementing user developed solver algorithms in PXO is easy. PXO offers the added advantage of being able to be linked with MTEX [@RHielscher2015] to deal with crystallographic texture calculations and advanced grain structure analysis. As PXO offers tool to export as many available temporal grain structure slices as the user wishes, to a format able to be used in ABAQUS software for FEA, it offers a comparatively unique, viable and fast solution to researchers working in the field of Integrated Computational Materials Engineering (ICME) investigating structure-property-behaviour relationships. Additionally, PXO is able to combine this advantage with the ability to simulate grain growth in the presence of particles, particle clusters, fibres, whiskers and temperature fields. Another unique advantage is the capability of generating morphologically complex grain structure distribution.

# Example grain structures
![Example grain structures](Paper_images/example1.jpg)

Above figure shows some sample grain structures, which can be generated using PXO. [Tutorials](https://github.com/SunilAnandatheertha/PXO/wiki/Tutorials-and-test-cases) have been provided to help the user in getting started.

# Acknowledgements
The author acknowledges the computational resource offered by the institutions Indian Institute of Science during 2013-2014, PES University during 2014-2017 and Coventry University during 2017-2021. The author also acknowledges Dr. Kishore T Kashyap (Department of Mechanical Engineering, PESIT (now called as PES University), Bengaluru, India, in 2010) for his theoretical inputs on grain growth, Dr. G Narayana Naik (Department of Aerospace Engineering, Indian Institute of Science, Bengaluru, India) and Dr. N G Subramania Udupa (Nagarjuna College of Engineering and Technology, Bengaluru, India) for supervising the author’s master’s project in 2012-2014.

# References
