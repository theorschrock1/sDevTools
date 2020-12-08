#' test.

#' @name test_named_list
#' @param x  \code{[named_list]}  The list must have the following structure: \rcode{list(x = char(), y = string())}.
#' @param y  \code{[reactive]}  Must be a reactive expression which has an output type: \rcode{['named_list']}.  The list must have the following structure: \rcode{list(x = char(), y = string())}.
#' @return \code{test_named_list}: test
#' @export
test_named_list <- function(x, y) {
    # test
    assert_named_list(x, structure = list(x = char(), y = string()))
    assert_reactive(y, output_type = "named_list", structure = list(x = char(), y = string()))
    # Returns: test
}
