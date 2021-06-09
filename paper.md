---
title: 'PXO (Poly-XTAL Operations): MATLAB codebase to generate and analyse complex 2D grain structures '
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
Mathematicians, statistical mechanists and computational materials scientists are interested in studying the spatiotemporal evolutionary aspects of multi-phased partitioning of an n-dimensional space. Four examples for this are given and the statement of need is provided in each.

The 1st example is from mathematics. Here, researchers are interested in the chaotic partitioning of an n-D bounded spatial domain and its spatiotemporal evolution under some governing rules [@JMarkKlien1999]. Mathematicians need a computational platform to study n-dimensional partitions of space.

The 2nd example is from statistical mechanics. Here researchers are interested in importance sampling Monte-Carlo techniques studying the spatiotemporal evolution of the kinetics and thermodynamics of the distribution of multi-phase systems over some lattice. Exact solutions have been developed for such simple models involving 2 states [@Baxter1989], but for more complex models like the Q-state Pott’s model, an exact model is impractical due to the vastness of the solution space. Here, a computational platform is needed to simulate such models.

The 3rd example is from fundamental computational materials science. Here researchers are interested in grain growth [@Weaire1996], where the temporal evolution of spatial and thermodynamical parameters of multi-phase grain structures [@Anderson1984], [@Anderson1989] is studied. Here, a computational platform is used to simulate grain growth. A part of this research also touches upon understanding the kinematic and kinetic behaviour of insoluble 2nd phase particles in grain structures [@Srolovitz1984] and how they interact with the grain boundaries. Some of these studies have tried to validate empirical models of grain structure geometry such as the Zener equation [@Manohar1998]. As the shape of the particles influence the Zener drag working against grain boundary evolution during grain growth [@Li1990], and that nature presents irregularly shaped particles, computer models which can consider such particle shape and their spatial distribution becomes very essential. A platform is needed where such studies can be made numerically.

The 4th example is from applied computational materials science. Here, researchers use techniques such as crystal plasticity based finite element analysis to study material’s phase-partitioned thermo-mechanical response and texture evolution under applied thermo-mechanical loads [@Roters2010]. Computational materials scientists studying multi-scale thermo-mechanical and texture behaviour of poly-crystalline materials need parametric and realistically tessellated geometric morphologies of the constituent phases reflected in the virtual grain structure. They use such grain structures as an input to further studies such as crystal plasticity based finite element analysis. Though Voronoi tessellated geometries of grain structures have been used before, they are simplifications and do not accurately represent the geometric irregularities presented by nature. However, it is difficult to generate parametric spatially gradient physically realistic grain structures with multiple temporally low gradient slices. It is also difficult for many to get grain structures using techniques like EBSD and even difficult to process them and use them numerically. Similar needs are also present in computational geology. A computer software program capable of preparing artificial and physically realistic grain structures for use in FEM is needed.

# Summary
Poly-Xtal operations ('PXO') is a MATLAB based computational platform enabling users to create and prepare realistic grain structures for finite element analysis, simulate complex grain growth phenomenon and achieve spatiotemporal partition a 2D space into a set of closed regions. In addition to various in-built tools, 'PXO' can output the grain structure in a format which can be further imported into 3rd party open source libraries to tend to the specific requirements of the user.

# Documentations
All documentations and test cases are available in the [PXO/Wiki](https://github.com/SunilAnandatheertha/PXO/wiki).

# State of the field
Over the past few decades, MATLAB has emerged to be an easy to use, powerful and robust, high-level computational platform with ample documentation and a growing scientific and engineering community. PXO, written in MATLAB offers these research community an added advantage over other softwares. Options like MCPM [@JKMason2015], NEPER [@Quey2014] and DREAM3D [@MAGroeber2014] are available to model grain structure. These are either application specific or written in a computer language or in an operating system which people with a non-software background would find it hard to use and/or modify. Implementing user developed solver algorithms in PXO is easy. PXO offers the added advantage of being able to be linked with MTEX to deal with crystallographic texture calculations and advanced grain structure analysis. As PXO offers tool to export as many available temporal slices of the grain structure as needed to a format able to be used in ABAQUS for finite element analysis, it offers a comparatively unique, viable and fast solution to researchers working in the field of Integrated Computational Materials Engineering (ICME) investigating structure-property-behaviour relationships. Additionally, PXO is able to combine this advantage with the ability to simulate grain growth in the presence of particles, particle clusters, fibres, whiskers and temperature fields. Another unique advantage is the offer of Kernel functions, using which complex morphological arrangement of grains can be generated.

# Example grain structures
![Example grain structures](Paper_images/example1.jpg)

Above figure shows some sample grain structures which can be generated using PXO. Test case inputs needed to produce them are in the page [Wiki/TestCases](https://github.com/SunilAnandatheertha/PXO/wiki/Test-cases)

# Acknowledgements

The author acknowledges the computational resource offered by the institutions Indian Institute of Science during 2013-2014, PES University during 2014-2017 and Coventry University during 2017-2021. The author also acknowledges Dr. Kishore T Kashyap (Department of Mechanical Engineering, PESIT (now called as PES University), Bengaluru, India, in 2010) for his theoretical inputs on general grain growth, Dr. G Narayana Naik (Department of Aerospace Engineering, Indian Institute of Science, Bengaluru, India) and Dr. N G Subramania Udupa (Nagarjuna College of Engineering and Technology, Bengaluru, India) for supervising the author’s master’s project in 2012-2014.

# References
