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
comuni <- comuni %>% select(cod_comune:pop_legale, cod_provincia, cod_regione)
province <- province %>% select(cod_provincia:sigla_auto)

## ------------------------------------------------------------------------
comuni %>% left_join(province)
comuni %>% left_join(regioni)
comuni %>% left_join(province) %>% left_join(regioni)

## ------------------------------------------------------------------------
comuni %>% left_join(province)

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
data(tennis) 

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

## ------------------------------------------------------------------------
ripartizioni2 <-
  data.frame(cod_rip_geo = c("1","2"), rip_geo = rep("Nord",2)) %>%
  bind_rows(ripartizioni)
ripartizioni3 <- ripartizioni2 %>% slice(c(1,5,6))
ripartizioni3$rip_geo[3] <- "Mezzogiorno"
ripartizioni
ripartizioni3

## ------------------------------------------------------------------------
intersect(ripartizioni, ripartizioni3)
union(ripartizioni, ripartizioni3) # Note that we get 7 rows, not 8
setdiff(ripartizioni, ripartizioni3)
setdiff(ripartizioni3, ripartizioni)

## ------------------------------------------------------------------------
# First data frame
ripartizioni4 <- ripartizioni
ripartizioni4$rip_geo <- factor(ripartizioni4$rip_geo)
ripartizioni4
ripartizioni4 %>% str
# Second data frame
ripartizioni5 <- ripartizioni3
ripartizioni5$rip_geo <- factor(ripartizioni5$rip_geo)
ripartizioni5
ripartizioni5 %>% str
# Join
(joined_df <- ripartizioni4 %>% full_join(ripartizioni5))
joined_df %>% str()

## ------------------------------------------------------------------------
# First data frame
ripartizioni4$rip_geo <- factor(ripartizioni4$rip_geo,
                                levels = c("Centro","Isole","Nord-est","Nord-ovest","Sud",
                                           "Nord","Mezzogiorno"))
ripartizioni4
ripartizioni4 %>% str
# Second data frame
ripartizioni5$rip_geo <- factor(ripartizioni5$rip_geo,
                                levels = c("Nord","Centro","Mezzogiorno",
                                           "Isole","Nord-est","Nord-ovest","Sud"))
ripartizioni5
ripartizioni5 %>% str
# Join
(joined_df <- ripartizioni4 %>% full_join(ripartizioni5))
joined_df %>% str()

## ------------------------------------------------------------------------
# First data frame
ripartizioni4$rip_geo <- factor(ripartizioni4$rip_geo,
                                levels = c("Nord","Centro","Mezzogiorno",
                                           "Nord-est","Nord-ovest","Sud","Isole"))
ripartizioni4
ripartizioni4 %>% str
# Second data frame
ripartizioni5$rip_geo <- factor(ripartizioni5$rip_geo,
                                levels = c("Nord","Centro","Mezzogiorno",
                                           "Nord-est","Nord-ovest","Sud","Isole"))
ripartizioni5
ripartizioni5 %>% str
# Join
(joined_df <- ripartizioni4 %>% full_join(ripartizioni5))
joined_df %>% str()

## ------------------------------------------------------------------------
# First data frame
ripartizioni
ripartizioni %>% str
# Second data frame
ripartizioni4
ripartizioni4 %>% str
# Join
(joined_df <- ripartizioni %>% full_join(ripartizioni4))
joined_df %>% str()

## ------------------------------------------------------------------------
# First data frame
ripartizioni6 <- ripartizioni3
ripartizioni6$cod_rip_geo <- as.numeric(ripartizioni6$cod_rip_geo)
ripartizioni6
ripartizioni6 %>% str
# Second data frame
ripartizioni7 <- ripartizioni6
ripartizioni7$cod_rip_geo[3] <- 4.5
ripartizioni7
ripartizioni7 %>% str
# Join
(joined_df <- ripartizioni6 %>% full_join(ripartizioni7))
joined_df %>% str()

## ---- error=TRUE---------------------------------------------------------
# First data frame
ripartizioni6
ripartizioni6 %>% str
# Second data frame
ripartizioni3
ripartizioni3 %>% str
# Join
(joined_df <- full_join(ripartizioni6, ripartizioni3))

