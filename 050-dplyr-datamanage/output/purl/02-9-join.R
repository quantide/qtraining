## ----first, include=TRUE, message=FALSE----------------------------------
require(tidyverse) # alternatively: require(dplyr)
require(qdata)
data(comuni)
data(province)
data(regioni)
data(usopen)
data(wimbledon)

## ------------------------------------------------------------------------
df1 <- data.frame(id = 1:4, x1 = letters[1:4])
df2 <- data.frame(id = 3:5, x2 = letters[3:5])

## ------------------------------------------------------------------------
inner_join(df1, df2)

## ------------------------------------------------------------------------
left_join(df1, df2)

## ------------------------------------------------------------------------
right_join(df1, df2)
left_join(df2, df1)


## ------------------------------------------------------------------------
full_join(df1, df2)

## ------------------------------------------------------------------------
comuni <- comuni %>% select(cod_comune:pop_legale, cod_provincia:cod_regione)
province <- province %>% select(cod_provincia:cod_citta_metro)

## ------------------------------------------------------------------------
comuni %>% left_join(province)
comuni %>% left_join(regioni)
comuni %>% left_join(province) %>% left_join(regioni)

## ------------------------------------------------------------------------
comuni %>% left_join(regioni)

## ------------------------------------------------------------------------
comuni %>% left_join(province)

## ------------------------------------------------------------------------
comuni %>% left_join(province, by = "cod_provincia")

## ------------------------------------------------------------------------
regioni2 <- regioni %>% rename(id_regione = cod_regione)

## ------------------------------------------------------------------------
comuni %>% left_join(regioni2, c("cod_regione" = "id_regione"))

## ------------------------------------------------------------------------
  province %>%
  left_join(comuni) %>%
  group_by(provincia) %>%
  summarise(pop_legale = sum(pop_legale)) %>% 
  arrange(desc(pop_legale))

## ------------------------------------------------------------------------
  regioni %>%
  left_join(comuni) %>%
  group_by(regione) %>%
  summarise(pop_legale = sum(pop_legale)) %>%
  arrange(desc(pop_legale))

## ------------------------------------------------------------------------
  comuni %>%
  filter(comune_cap_prov == TRUE) %>%
  select(comune, pop_legale) %>% 
  arrange(desc(pop_legale))

## ------------------------------------------------------------------------
df1 <- data.frame(id = 1:4, x1 = letters[1:4])
df2 <- data.frame(id = 3:5, x2 = letters[3:5])

## ------------------------------------------------------------------------
df1 %>% semi_join(df2)

## ------------------------------------------------------------------------
df1 %>% anti_join(df2)

## ------------------------------------------------------------------------
usopen %>% 
  anti_join(wimbledon, by = "champion") %>%
  select(year, champion_country, champion)

## ------------------------------------------------------------------------
usopen %>% 
  semi_join(wimbledon, by = "champion") %>%
  select(year, champion_country, champion)

## ------------------------------------------------------------------------
usopen %>% 
  semi_join(wimbledon, by = c("champion", "year")) %>%
  select(year, champion_country, champion)

## ------------------------------------------------------------------------
# who won the US open more than once
super_usopen <- usopen %>% 
  group_by(champion) %>%
  summarise (n_us = n()) %>%
  filter(n_us > 1)

# who won Wimbledon more than once
super_wimbledon <- wimbledon %>% 
  group_by(champion) %>%
  summarise (n_wb = n()) %>%
  filter(n_wb > 1)

# semi join
super_usopen %>% 
  semi_join(super_wimbledon, by = "champion") %>%
  select(champion)

## ------------------------------------------------------------------------
super_usopen %>% 
  inner_join(super_wimbledon, by = "champion") %>%
  mutate ( n = n_us+n_wb) %>%
  arrange(desc(n))

## ------------------------------------------------------------------------
df1 <- data.frame(x = 1:3, y = 3:1)
df2 <- data.frame(x = 4:6, y = 6:4)
df1 %>% bind_rows(df2)

## ------------------------------------------------------------------------
df1 <- data.frame(x1 = 1:3, y1 = 3:1)
df2 <- data.frame(x2 = 4:6, y2 = 6:4, z2 = 0)
df1 %>% bind_rows(df2)

## ------------------------------------------------------------------------
df1 <- data.frame(x = 1:3, y = 3:1)
df2 <- data.frame(x = 4:6, y = 6:4)
df1 %>% bind_cols(df2)

## ------------------------------------------------------------------------
df1 <- data.frame(x1 = 1:3, y1 = 3:1)
df2 <- data.frame(x2 = 4:6, y2 = 6:4, z2 = 0)
df1 %>% bind_cols(df2)

