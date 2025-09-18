## Packages test version
###########
## rsvg               2.6.1
## R.utils            2.12.3


## Converts an image (raster/vector) to another image format (raster/vector) when possible
## Supports multiple output formats in a single call (ex : output_format = c('bmp', 'png'))
image_convert <- function(input_file = NULL, res = 72, output_format = c('png'), input_gzip = FALSE, bitmap_compress = 'LZMA') {
  if(!file.exists(svg_file)) stop('svg_file not found !')
  img_in <- magick::image_read(path = input_file, density = res)
  for (bf in output_format) {
    try(magick::image_write(image = img_in, path = paste0(tools::file_path_sans_ext(input_file), '.', tolower(bf)), format = bf, density = res, compression = bitmap_compress))
  }
  if (input_gzip) R.utils::gzip(input_file, remove = TRUE, overwrite = TRUE)
}

# ## Convert SVG to PNG ====
# .svg_convert <- function(svg_files = NULL, format = 'png', compress = TRUE, ...) {
#   valid_formats <- c('eps', 'png', 'pdf', 'ps', 'svg')
#   if (!format %in% valid_formats) stop(paste0('Unsupported format ! Supported formats are : "', paste(valid_formats, collapse = '", "'), '"'))
#   for (s in svg_files) {
#     do.call(what = eval(parse(text = paste0('rsvg::rsvg_', format))), args = list(svg = s, file = sub(pattern = '\\.svg$', replacement = paste0('.', tolower(format)), x = s, ignore.case = TRUE), ...))
#     if (compress) R.utils::gzip(s, remove = TRUE, overwrite = TRUE)
#   }
# }
# 
# ## SVG2PNG+GZ ====
# ## Device manager to convert an open 'svg' device to raster (PNG by default) and compress (gzip) the original SVG, then close the device
# svg_off <- function(format = 'png', compress = TRUE, ...) {
#   ## Checks
#   valid_formats <- c('eps', 'png', 'pdf', 'ps', 'svg')
#   if (!format %in% valid_formats) stop(paste0('Unsupported format ! Supported formats are : "', paste(valid_formats, collapse = '", "'), '"'))
#   ## Get current device
#   cur_dev <- .Device
#   ## Check if device is actually a SVG
#   if (!cur_dev %in% c('svg', 'devSVG')) stop(paste0("Latest open device is not 'svg' : ", as.character(cur_dev)))
#   ## Get filename
#   svg_file <- attr(x = cur_dev, which = 'filepath', exact = TRUE)
#   ## Get device dimensions
#   dev_w <- dev.size()[1]*96
#   dev_h <- dev.size()[2]*96
#   ## Close device
#   dev.off()
#   ## Convert to raster
#   .svg_convert(svg_files = svg_file, format = format, compress = compress, width = dev_w, height = dev_h)
# }
