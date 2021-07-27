import pandas as pd 
import plotly.graph_objects as go 
import dash
import dash_core_components as dcc 
import dash_html_components as html 
from dash.dependencies import Input, Output

url = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
    '$select=spc_common,count(tree_id)' +\
        '&$group=spc_common').replace(' ', '%20')
trees_dataset = pd.read_json(url)
trees_list = trees_dataset['spc_common'].dropna() # List of trees
Boroughs = ['Brooklyn', 'Bronx', 'Manhattan', 'Queens', 'Staten Island'] # List of boroughs

app = dash.Dash()
server = app.server

app.layout = html.Div([
    html.H1('Health of NYC Trees App'),
    dcc.Dropdown(
        id = 'Select_borough',
        options = [
        {'label': Boroughs[i], 'value': Boroughs[i]} for i in range(len(Boroughs))
        ], value = Boroughs[3]
    ),
    dcc.Dropdown(
        id = 'Select_species',
        options = [
        {'label': trees_list[i], 'value': trees_list[i]} for i in range(len(trees_list))
        ], value = trees_list[0]
    ),
    dcc.Graph(id = 'Combined_graph'), # Graph showing all trees
    dcc.Graph(id = 'Health_graph'), # Graph showing a single tree
    dcc.Graph(id = 'Stewards_graph') # Graph showing stewards
])

@app.callback(
    Output('Combined_graph', 'figure'),
    Input('Select_borough', 'value')
)
def update_graphs(borough):
    soql_url = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
    '$select=spc_common,health,count(tree_id)' +\
        '&$where=boroname=\'{}\'' +\
            '&$group=spc_common,health').format(borough).replace(' ', '%20')
    data = pd.read_json(soql_url)
    soql_trees = data.copy()
    soql_trees['proportion'] = soql_trees.loc[:, 'count_tree_id'] / soql_trees.groupby('spc_common')['count_tree_id'].transform(sum) # Calculate proportion
    trace1 = go.Bar(x = soql_trees.loc[soql_trees['health'] == 'Good', 'spc_common'],
                    y = soql_trees.loc[soql_trees['health'] == 'Good', 'proportion']
                    )
    trace2 = go.Bar(x = soql_trees.loc[soql_trees['health'] == 'Fair', 'spc_common'],
                    y = soql_trees.loc[soql_trees['health'] == 'Fair', 'proportion']
                    )
    trace3 = go.Bar(x = soql_trees.loc[soql_trees['health'] == 'Poor', 'spc_common'],
                    y = soql_trees.loc[soql_trees['health'] == 'Poor', 'proportion']
                    )
    return {
        'data': [trace1, trace2, trace3],
        'layout': go.Layout(
            title = 'Proportion of Health for Trees in {}'.format(borough),
            barmode = 'stack'
        )
    }

@app.callback(
    Output('Health_graph', 'figure'),
    [Input('Select_borough', 'value'), Input('Select_species', 'value')]
)
def update_graphs(borough, species):
    soql_url = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
    '$select=spc_common,health,count(tree_id)' +\
        '&$where=boroname=\'{}\'' +\
            '&$group=spc_common,health').format(borough).replace(' ', '%20')
    data = pd.read_json(soql_url)
    soql_trees = data.copy()
    soql_trees = soql_trees[soql_trees['spc_common'] == species]
    soql_trees['proportion'] = soql_trees.loc[:, 'count_tree_id'] / soql_trees.groupby('spc_common')['count_tree_id'].transform(sum) # Calculate proportion
    trace1 = go.Bar(x = soql_trees.loc[soql_trees['health'] == 'Good', 'spc_common'],
                    y = soql_trees.loc[soql_trees['health'] == 'Good', 'proportion']
                    )
    trace2 = go.Bar(x = soql_trees.loc[soql_trees['health'] == 'Fair', 'spc_common'],
                    y = soql_trees.loc[soql_trees['health'] == 'Fair', 'proportion']
                    )
    trace3 = go.Bar(x = soql_trees.loc[soql_trees['health'] == 'Poor', 'spc_common'],
                    y = soql_trees.loc[soql_trees['health'] == 'Poor', 'proportion']
                    )
    return {
        'data': [trace1, trace2, trace3],
        'layout': go.Layout(
            title = 'Proportion of Health for {} in {}'.format(species, borough),
            barmode = 'stack'
        )
    }

@app.callback(
    Output('Stewards_graph', 'figure'),
    [Input('Select_borough', 'value'), Input('Select_species', 'value')]
)
def update_graphs(borough, species):
    soql_url = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
    '$select=spc_common,health,steward,count(tree_id)' +\
        '&$where=boroname=\'{}\'' +\
            '&$group=spc_common,health,steward').format(borough).replace(' ', '%20')
    data = pd.read_json(soql_url)
    soql_trees = data.copy()
    soql_trees = soql_trees[soql_trees['spc_common'] == species]
    soql_trees['proportion'] = soql_trees.loc[:, 'count_tree_id'] / soql_trees.groupby('spc_common')['count_tree_id'].transform(sum) # Calculate proportion
    trace1 = go.Bar(x = soql_trees.loc[soql_trees['health'] == 'Good', 'steward'],
                    y = soql_trees.loc[soql_trees['health'] == 'Good', 'count_tree_id'], name = 'Good'
                    )
    trace2 = go.Bar(x = soql_trees.loc[soql_trees['health'] == 'Fair', 'steward'],
                    y = soql_trees.loc[soql_trees['health'] == 'Fair', 'count_tree_id'], name = 'Fair'
                    )
    trace3 = go.Bar(x = soql_trees.loc[soql_trees['health'] == 'Poor', 'steward'],
                    y = soql_trees.loc[soql_trees['health'] == 'Poor', 'count_tree_id'], name = 'Poor'
                    )
    return {
        'data': [trace1, trace2, trace3],
        'layout': go.Layout(
            title = 'Stewards Impact on {} in {}'.format(species, borough),
            barmode = 'stack'
        )
    }
if __name__ == '__main__':
    app.run_server(debug = True)
