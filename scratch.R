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



#;; Don't use a coordinate system.
#;; Save as: images/ch01_single-vector-coords-red-circle-slash.png
#;; Ref: https://stackoverflow.com/a/12633891/1022967
forbidden_png <- png::readPNG('images/red-circle-slash.png')
(p2 <- p +
    theme_bw() +
    theme(axis.title.x = element_blank(), axis.title.y = element_blank()) +
    annotation_raster(forbidden_png, ymin = 0.35,ymax= 0.85,xmin = 0.25, xmax = 0.75) + 
    geom_point()
)
ggsave(here::here("images", "ch01_single-vector-coords-red-circle-slash.png"), p2, width=3, height=3, units = "in")

#;; Make a red X on the plot
# redX_df <-
#     tribble(
#         ~startx, ~dx, ~starty, ~dy,
#         0.1, 0.8, 0.1, 0.8,
#         0.1, 0.8, 0.9, -0.8)
# 
# p +
#     theme_bw() +
#     theme(axis.title.x = element_blank(), axis.title.y = element_blank()) +
#     geom_segment(data=redX_df,
#                  mapping=aes(xend=startx+dx, yend=starty+dy),
#                  color="red", size=1)



#;; vector additive inverse
#;; Save as: images/ch01_additive-inverse.png
data_df <-
    tribble(
        ~startx, ~dx, ~starty, ~dy,
        0, 1, 0, 0.5,
        1, -1, 0.7, -0.5)
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
ggsave(here::here("images", "ch01_additive-inverse.png"), p, width=3, height=3, units = "in")










#;; 3 Vectors
#;; Ref: https://stackoverflow.com/questions/50163855/label-the-midpoint-of-a-segment-in-ggplot
data_df <-
    tribble(
        ~startx, ~dx, ~starty, ~dy, ~color,
        0, 1, 0, 1,"black",
        1, 1, 1, 0,"black",
        0, 2, 0, 1,"red"
    )
dataLabels_df <-
    data_df %>%
    transmute(pointx = c(0.5,1.6,1.1),
           pointy = c(0.7, 1.2, 0.45),
           lab = c("first push", "second push", "single push you could have done instead"))
(p <- ggplot(data=data_df, aes(x=startx,y=starty), environment = environment()) + 
        geom_point(size = 1) + 
        geom_segment(aes(xend=startx+dx, yend=starty+dy, color=color), arrow = arrow(length = unit(0.5, "cm")),
                     lineend = "round", linejoin = "round", size=2) + 
        geom_text(data=dataLabels_df, mapping=aes(x=pointx, y=pointy, label=lab), angle=27, size=3) +
        scale_color_manual(values=c("black"="black", "red"="red")) +
        # xlim(min(data_df$startx),max(data_df$startx + data_df$dx)) + 
        # ylim(min(data_df$starty),max(data_df$starty + data_df$dy)) +
        xlim(0,2) + 
        ylim(0,2) +
        theme_void() +
        theme(legend.position = "none")
)
ggsave(here::here("images", "ch01_three-vector-resultant.png"), p, width=3, height=3, units = "in")
