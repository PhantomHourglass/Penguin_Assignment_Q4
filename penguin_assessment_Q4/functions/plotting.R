source("functions/libraries.R")

plot_bodymass_figure <- function(gentoo_and_chinstrap){
  ggplot(gentoo_and_chinstrap, aes(x = body_mass_g, colour = species)) +
    scale_colour_brewer(palette='Set1') +
    geom_vline(aes(xintercept=group.mean(gentoo_and_chinstrap$body_mass_g, gentoo_and_chinstrap$species), color = species), linetype = 'dashed') +
    geom_histogram(binwidth = 40 , position='identity', alpha=0.2) +
    labs(title="Gentoo and Chinstrap Penguin bodymass distributions", subtitle = 'T-test visual', x = "Body Mass (g)", y = "Frequency") +
    theme_classic()
}

save_bodymass_plot_png <- function(gentoo_and_chinstrap, 
                                  filename, size = 15, res = 600, scaling = 1.8){
  agg_png('figures/gentoo_chinstrap_bodymass_plot_png', width   =  30, 
          height  =  15, 
          units   =  "cm", 
          res     =  600, 
          scaling =  1.8)
  bodymass_plot <- plot_bodymass_figure(gentoo_and_chinstrap)
  print(bodymass_plot)
  dev.off()
}



save_bodymass_plot_svg <- function(gentoo_and_chinstrap, 
                                  filename, size = 15, scaling = 1.8){
  svglite('figures/gentoo_chinstrap_bodymass_plot_svg.svg', 
          width = 12, 
          height  = 5.9, 
          scaling = 1.8)
  bodymass_plot <- plot_bodymass_figure(gentoo_and_chinstrap)
  print(bodymass_plot)
  dev.off()
}


