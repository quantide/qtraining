## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(ggplot2)
require(qdata)
data(bands)

## ----histogram_first, message=FALSE, warning=FALSE-----------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + geom_histogram()

## ----histogram_aes, message=FALSE, warning=FALSE-------------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + geom_histogram(fill="#2B4C6F", colour="#3690c0")

## ----histogram_bins, message=FALSE, warning=FALSE------------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + geom_histogram(fill="#2B4C6F", colour="#3690c0", bins=6)

## ----histogram_binwidth, message=FALSE, warning=FALSE--------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + geom_histogram(fill="#2B4C6F", colour="#3690c0", binwidth=7)

## ----histogram_mapping, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(mapping=aes(fill=proof_on_ctd_ink))

## ----histogram_mapping_hide, message=FALSE, warning=FALSE----------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(mapping=aes(fill=press_type))

## ----histogram_facetgrid_col, message=FALSE, warning=FALSE---------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(. ~ press_type)

## ----histogram_facetgrid_row, message=FALSE, warning=FALSE---------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(type_on_cylinder ~ .)

## ----histogram_facetgrid_row_col, message=FALSE, warning=FALSE-----------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(type_on_cylinder ~ press_type)

## ----histogram_facetwrap, message=FALSE, warning=FALSE-------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_wrap(~ press_type)

## ----histogram_facetwrap_fill, message=FALSE, warning=FALSE--------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(mapping=aes(fill=press_type)) +
  guides(fill=FALSE) +
  facet_wrap(~ press_type)

## ----histogram_density, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=ink_pct, y=..density..)) +
  geom_histogram(fill="#74a9cf")

## ----histogram_geomdensity, message=FALSE, warning=FALSE-----------------
ggplot(data=bands, mapping=aes(x=ink_pct, y=..density..)) +
  geom_histogram(fill="#74a9cf") + geom_density(colour="#034e7b")

## ----histogram_geomline_density, message=FALSE, warning=FALSE------------
ggplot(data=bands, mapping=aes(x=ink_pct, y=..density..)) +
  geom_histogram(fill="#74a9cf") + geom_line(stat="density", colour="#034e7b")

