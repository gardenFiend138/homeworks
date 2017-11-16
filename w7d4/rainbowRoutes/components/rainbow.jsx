import React from 'react';
import {
  Route,
  Link,
  NavLink
} from 'react-router-dom';

import Red from './red';
import Green from './green';
import Blue from './blue';
import Violet from './violet';

class Rainbow extends React.Component {
  render() {
    return (
      <div>
        <h1>Rainbow Router!</h1>

// phase 1: use 'Link'
        // <Link to='/red' >Red</Link>
        // <Link to='/green' >Green</Link>
        // <Link to='/blue' >Blue</Link>
        // <Link to='/violet' >Violet</Link>
// phase 2: use 'Navlink'
        <Navlink to='/red' >Red</Navlink>
        <Navlink to='/green' >Green</Navlink>
        <Navlink to='/blue' >Blue</Navlink>
        <Navlink to='/violet' >Violet</Navlink>
        
        <div id="rainbow">
          <Route path="/red" component="{Red}"/>
          <Route path="/green" component="{Green}"/>
          <Route path="/blue" component="{Blue}"/>
          <Route path="/violet" component="{Violet}"/>
        </div>
      </div>
    );
  }
};

export default Rainbow;
