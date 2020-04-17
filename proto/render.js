export function render_values(group,values) {
  d3.select("#"+group).selectAll("div").data(values)
    .join("div")
      .text(d=>""+d.name+": ")
      .append("span")
        //.style("align","right")
        .classed("value", true)
}

export function render_buttons(group,buttons) {
  let button_width = 100
  let button_dist_h = 120
  let button_height = 40
  let button_dist_v = 50
  let buttons_in_row = 2
  d3.select("#"+group).selectAll("svg").data([0]).join("svg")
  d3.select("#"+group).select("svg").selectAll("g")
    .data(buttons,function(d) { return d ? d.name : this.id; })
    .join(
      enter => enter.append("g")
        .call(enter => enter
          .append("rect")
            .attr("width", button_width)
            .attr("height", button_height)
        ).call(enter => enter
          .append("text")
            .attr("x",5)
            .attr("y",button_height/2)
            .text(d=>d.name)
        )
        .classed("button", true)
        .on("click",d=>handle_click(d.id))
        .attr("transform", (d, i) =>
          "translate("
          + button_dist_h*(i%buttons_in_row)
          + ","
          + button_dist_v*Math.floor(i/buttons_in_row)
          + ")"
        ),
      update => update.call(update => update
        .transition().attr("transform", (d, i) =>
          "translate("
          + button_dist_h*(i%buttons_in_row)
          + ","
          + button_dist_v*Math.floor(i/buttons_in_row)
          + ")"
      ))
    )
    
  // // show usage count as resources
  // buttons.each(d=>{
  //   d3.select("#resources")
  //   .append("div")
  //     .datum({amount: d.uses})
  //     .text(d.name+": ")
  //     .append("span")
  //       .classed("resource", true)
  // })


}
export function update_vals(vals) {
  d3.selectAll(".value")
    .text(d=>d.amount?vals[d.amount].toPrecision(3):d.constant.toPrecision(3))
  d3.selectAll(".button")
    .classed("disabled",d=>vals[d.enabled]<1)
}
