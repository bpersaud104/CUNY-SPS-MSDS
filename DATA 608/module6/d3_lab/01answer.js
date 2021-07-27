d3.csv('ue_industry.csv', data => {

    // Define your scales and generator here.
    let xScale = d3.scaleLinear().domain(d3.extent(data, d => +d.index)).range([20, 1180]);
    let yScale = d3.scaleLinear().domain(d3.extent(data, d => +d.Agriculture)).range([580, 20]);

    let lineAnswer = d3.line()
    .x(d => xScale(d.index))
    .y(d => yScale(d.Agriculture));

    d3.select('#answer1')
        // append more elements here
        .append('path')
        .attr('d', lineAnswer(data))
        .attr('stroke', '#2e2928');

});
