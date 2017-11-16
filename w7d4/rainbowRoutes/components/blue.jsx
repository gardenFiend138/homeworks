import React from 'react';
import { Route, Link, NavLink } from 'react-router-dom';
import Indigo from './indigo';


class Blue extends React.Component {
  render() {
    return (
      <div>
        <h2 className="blue"></h2>
        <Navlink exact to='/blue' >Blue Only</Navlink>
        <Navlink to='blue/indigo' >Add indigo</Navlink>

        <Route path='/blue/indigo' component={Indigo} />
      </div>
    );
  }
};

export default Blue;
