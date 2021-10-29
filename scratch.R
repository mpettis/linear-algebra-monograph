#;; Scratch R code


#;; Drawing vectors
# Ref: https://codereview.stackexchange.com/questions/93974/plotting-a-vector-field-in-r-ggplot
# Ref: https://gist.github.com/djnavarro/7086df82d911b2149739821585e5593c
# Ref: https://ggplot2.tidyverse.org/reference/geom_segment.html

library(ggplot2)
library(dplyr)

#;; Draw an arrow
#;; Save as: images/ch01_single-vector.png
data_df <-
    tribble(
        ~startx, ~dx, ~starty, ~dy,
        0, 1, 0, 0.5)
(p <- ggplot(data=data_df, aes(x=startx,y=starty), environment = environment()) + 
    geom_point(size = 1) + 
    geom_segment(aes(xend=startx+dx, yend=starty+dy), arrow = arrow(length = unit(0.04, "npc")),
                 lineend = "round", linejoin = "bevel", size=1.5) + 
    # xlim(min(data_df$startx),max(data_df$startx + data_df$dx)) + 
    # ylim(min(data_df$starty),max(data_df$starty + data_df$dy)) +
    xlim(0,1) + 
    ylim(0,1) +
    theme_void()
)
ggsave(here::here("images", "ch01_single-vector.png"), p, width=3, height=3, units = "in")



#;; 
#;; Save as: images/ch01_single-vector-coords.png

redX_df <-
    tribble(
        ~startx, ~dx, ~starty, ~dy,
        0.1, 0.8, 0.1, 0.8,
        0.1, 0.8, 0.9, -0.8)


p +
    theme_bw() +
    theme(axis.title.x = element_blank(), axis.title.y = element_blank()) +
    geom_segment(data=redX_df,
                 mapping=aes(xend=startx+dx, yend=starty+dy),
                 color="red", size=1.5)



#;;
data_df <-
    tribble(
        ~startx, ~dx, ~starty, ~dy,
        0, 1, 0, 1,
        1, 1, 1, 0,
        0, 2, 0, 1
    )

ggplot(data=data_df, aes(x=startx,y=starty), environment = environment()) + 
    geom_point(size = 1) + 
    geom_segment(aes(xend=startx+dx, yend=starty+dy), arrow = arrow(length = unit(0.5, "cm")),
                 lineend = "round", linejoin = "round", size=2) + 
    # xlim(min(data_df$startx),max(data_df$startx + data_df$dx)) + 
    # ylim(min(data_df$starty),max(data_df$starty + data_df$dy)) +
    xlim(0,2) + 
    ylim(0,2) +
    theme_void()
