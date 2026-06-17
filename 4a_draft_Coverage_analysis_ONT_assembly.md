

LIB008 quercusBallota

ONT:
```{r}
ont_coverage_LIB008=read.csv2("C:/Users/jorge/Desktop/ICIFOR/Genomics_Quercus/Qilexballota_LIB008/assembly/verkko_ONT_coverage/assembly.ont-coverage.csv", sep="\t")



ont_cov_plot_LIB008 <- ont_coverage_LIB008 %>%
  mutate(
    coverage = as.numeric(coverage),
    length_bp = as.numeric(length)   # <- importante para evitar overflow
  ) %>%
  arrange(desc(length_bp)) %>%       # opcional: ordena de mayor a menor unitig
  mutate(
    start = lag(cumsum(length_bp), default = 0),
    end = cumsum(length_bp),
    midpoint = start + length_bp / 2
  )


median_LIB008=median(ont_cov_plot_LIB008$coverage)

##plot
ggplot(ont_cov_plot_LIB008) +
  geom_rect(
    aes(
      xmin = start / 1e6,
      xmax = end / 1e6,
      ymin = 0,
      ymax = coverage
    ),
    fill = "grey70",
    color = "black",
    linewidth = 0.2
  ) +
  geom_hline(
    yintercept =median_LIB008,
    linetype = "dashed"
  ) +
  labs(
    x = "Pseudo-assembly position (Mb)",
    y = "ONT coverage",
    title = "ONT coverage along Verkko unitigs"
  ) +
  theme_bw()


########¿Organelles >300x? ¿Reps?

Putative_organelles=ont_cov_plot_LIB008%>%
  filter(coverage>100)

```

HiFi:
```{r}
hifi_coverage_LIB008=read.csv2("C:/Users/jorge/Desktop/ICIFOR/Genomics_Quercus/Qilexballota_LIB008/assembly/verkko_ONT_coverage/assembly.hifi-coverage.csv", sep="\t")




hifi_cov_plot_LIB008 <- hifi_coverage_LIB008 %>%
  mutate(
    coverage = as.numeric(coverage),
    length_bp = as.numeric(length)   # <- importante para evitar overflow
  ) %>%
  arrange(desc(length_bp)) %>%       # opcional: ordena de mayor a menor unitig
  mutate(
    start = lag(cumsum(length_bp), default = 0),
    end = cumsum(length_bp),
    midpoint = start + length_bp / 2
  )

summary(hifi_cov_plot_LIB008)


median_LIB008_hifi=median(hifi_cov_plot_LIB008$coverage)

##plot
ggplot(hifi_cov_plot_LIB008) +
  geom_rect(
    aes(
      xmin = start / 1e6,
      xmax = end / 1e6,
      ymin = 0,
      ymax = coverage
    ),
    fill = "grey70",
    color = "black",
    linewidth = 0.2
  ) +
  geom_hline(
    yintercept =median_LIB008_hifi,
    linetype = "dashed"
  ) +
  labs(
    x = "Pseudo-assembly position (Mb)",
    y = "ONT coverage",
    title = "ONT coverage along Verkko unitigs"
  ) +
  theme_bw()


########¿Organelles >300x? ¿Reps?

Putative_organelles_hifi=hifi_cov_plot_LIB008%>%
  filter(coverage>40)
```




LIB009 Qilexilex

ONT

```{r}
ont_coverage_LIB009=read.csv2("C:/Users/jorge/Desktop/ICIFOR/Genomics_Quercus/Qilexilex_LIB009/assembly/verkko_ONT_coverage/assembly.ont-coverage.csv", sep="\t")



ont_cov_plot_LIB009 <- ont_coverage_LIB009 %>%
  mutate(
    coverage = as.numeric(coverage),
    length_bp = as.numeric(length)   # <- importante para evitar overflow
  ) %>%
  arrange(desc(length_bp)) %>%       # opcional: ordena de mayor a menor unitig
  mutate(
    start = lag(cumsum(length_bp), default = 0),
    end = cumsum(length_bp),
    midpoint = start + length_bp / 2
  )


median_ont_LIB009=median(ont_cov_plot_LIB009$coverage)

##plot
ggplot(ont_cov_plot_LIB009) +
  geom_rect(
    aes(
      xmin = start / 1e6,
      xmax = end / 1e6,
      ymin = 0,
      ymax = coverage
    ),
    fill = "grey70",
    color = "black",
    linewidth = 0.2
  ) +
  geom_hline(
    yintercept =median_ont_LIB009,
    linetype = "dashed"
  ) +
  labs(
    x = "Pseudo-assembly position (Mb)",
    y = "ONT coverage",
    title = "ONT coverage along Verkko unitigs"
  ) +
  theme_bw()


########¿Organelles >300x? ¿Reps?

Putative_organelles_LIB009_ont=ont_cov_plot_LIB009%>%
  filter(coverage>100)
```
HIFI:


```{r}
hifi_coverage_LIB009=read.csv2("C:/Users/jorge/Desktop/ICIFOR/Genomics_Quercus/Qilexilex_LIB009/assembly/verkko_ONT_coverage/assembly.hifi-coverage.csv", sep="\t")



hifi_cov_plot_LIB009 <- hifi_coverage_LIB009 %>%
  mutate(
    coverage = as.numeric(coverage),
    length_bp = as.numeric(length)   # <- importante para evitar overflow
  ) %>%
  arrange(desc(length_bp)) %>%       # opcional: ordena de mayor a menor unitig
  mutate(
    start = lag(cumsum(length_bp), default = 0),
    end = cumsum(length_bp),
    midpoint = start + length_bp / 2
  )


median_hifi_LIB009=median(hifi_cov_plot_LIB009$coverage)

##plot
ggplot(hifi_cov_plot_LIB009) +
  geom_rect(
    aes(
      xmin = start / 1e6,
      xmax = end / 1e6,
      ymin = 0,
      ymax = coverage
    ),
    fill = "grey70",
    color = "black",
    linewidth = 0.2
  ) +
  geom_hline(
    yintercept =median_hifi_LIB009,
    linetype = "dashed"
  ) +
  labs(
    x = "Pseudo-assembly position (Mb)",
    y = "ONT coverage",
    title = "ONT coverage along Verkko unitigs"
  ) +
  theme_bw()


########¿Organelles >300x? ¿Reps?

Putative_organelles_LIB009_hifi=hifi_cov_plot_LIB009%>%
  filter(coverage>100)
```

