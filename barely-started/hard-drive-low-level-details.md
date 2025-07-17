# Hard Drives - Lower-level Details
- Track layouts
- Disk metadata locations (SMART, sector mapping, firmware, etc.)
- Interface protocols (IDE, APA, APAPI, SATA, SAS, etc.)



## Special-purpose disk regions
Special regions of disks such as HPA (Host Protected Area), DCO (Device Configuration Overlay), etc.

Basically there are ways for HDDs to store data in ways not visible to the computer's host OS through the normal methods.

- https://superuser.com/questions/722462/what-are-the-differences-between-host-protected-area-hpa-device-configuration
- I suggest reading ["Hidden Disk Areas: HPA and DCO", International Journal of Digital Evidence Fall 2006, Volume 5, Issue 1](https://www.utica.edu/academic/institutes/ecii/publications/articles/EFE36584-D13F-2962-67BEB146864A2671.pdf) and  ["The Impact of Hard Disk Firmware Steganography on Computer Forensics"][The Impact of Hard Disk Firmware Steganography on Computer Forensics] for more information on the basics of this.


#### Diagram of logical address space
Diagrams are based on ["Figure 1. Overview of Disk Areas", pp.75, "The Impact of Hard Disk Firmware Steganography on Computer Forensics"][The Impact of Hard Disk Firmware Steganography on Computer Forensics], and are essentially Ascii-art transciprtions of the diagram in the paper.

I'm using the controller firmware's available logical addressing (Controller-BOM, Controller-EOM) and logical addressing presented to the BIOS / Operating system (Logical-BOM and Logical-EOM) as distinct seperate terms here for clarity.
i.e. The normal logical Beginning of Media (BOM) presented to the BIOS / Operating system would be Logical-BOM.

- `n` is the logical address, with 0 being the start of user-addressable space.

Simplified logical layout (horizonal diagram):
```ascii-art
(n-) |__Disk Firmware Area (DFA)__|(n0)__User Addressable Data Area__|__Host Protected Area (HPA)__|__Device Configuration Overlay (DCO)__| (n+)
```

Simplified logical layout (vertical diagram)
```ascii-art
(n-) 
Controller's Beginning of Media (controller-EOM)
+----------
| Disk Firmware Area (DFA)
|-(n = -1)
+----- Logical-BOM
|-(n = 0) 
|
| User Addressable Data Area
|
+----- Logical-EOM
| Host Protected Area (HPA)
+-----
| Device Configuration Overlay (DCO)
+----------
Controller's End of Media (controller-EOM)
(n+)
```


####




## Links
Links, bibliograpy, further reading, sources, etc.

- 


### Patents


### Academic Papers
- 

### Host Protected Area, Device Configuration Overlay, etc
Special regions of disks such as HPA (Host Protected Area), DCO (Device Configuration Overlay), etc.
- https://superuser.com/questions/722462/what-are-the-differences-between-host-protected-area-hpa-device-configuration
- ["The Impact of Hard Disk Firmware Steganography on Computer Forensics" `Sutherland, Iain; Davies, Gareth; Pringle, Nick; and Blyth, Andrew (2009) "The Impact of Hard Disk Firmware Steganography on Computer Forensics," Journal of Digital Forensics, Security and Law: Vol. 4 : No. 2 , Article 5.`, `DOI: https://doi.org/10.15394/jdfsl.2009.1059`, `Available at: https://commons.erau.edu/jdfsl/vol4/iss2/5`][The Impact of Hard Disk Firmware Steganography on Computer Forensics] 
- ["Hidden Disk Areas: HPA and DCO", International Journal of Digital Evidence Fall 2006, Volume 5, Issue 1](https://www.utica.edu/academic/institutes/ecii/publications/articles/EFE36584-D13F-2962-67BEB146864A2671.pdf)

### Integrated Circuits


### On-disk 


### SAS


### IDE / ATA / ATAPI / CF


### Unsorted Links
- https://blog.stuffedcow.net/2019/09/hard-disk-geometry-microbenchmarking/
- https://blog.stuffedcow.net/2019/09/hard-disk-geometry-microbenchmarking/2/
- ["Hard and Floppy Disks", "CSCE 351 Operating System Kernels", Steve Goddard](https://cse.unl.edu/~goddard/Courses/CSCE351/Lectures/Lecture10.pdf)
- [ "Hard Disk Drives", Fall 2017 :: CSE 306, stonybrook.edu, Nima Honarmand (Based on slides by Prof. Andrea Arpaci-Dusseau)](https://compas.cs.stonybrook.edu/~nhonarmand/courses/fa17/cse306/slides/15-disks.pdf)
- Special negative-numbered tracks https://superuser.com/questions/709371/where-is-s-m-a-r-t-data-stored-on-a-hdd


## Link footer
Markdown 'reference' links go here at the end.
[The Impact of Hard Disk Firmware Steganography on Computer Forensics]: https://pdfs.semanticscholar.org/9715/aa3869283a4fb47ae042ba2b885027f55910.pdf
