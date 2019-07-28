import * as React from 'react';
import {Socket} from "phoenix"

class Case extends React.Component {
  render() {
    var style = {
      backgroundColor: 'black',
      border: '1px solid gray',
      width: '5px',
      height: '5px'
    }
    if (this.props.data === '0') { style['backgroundColor'] = 'white' }

    return <div className="case" style={style} ></div>
  }
}

class Line extends React.Component {
  render() {

    const style = {
      // border: '1px solid red',
      display: 'flex'
    }

    const elems = Array.from(this.props.data)

    const items = elems.map((el, index) =>
      <Case key={index} data={el} />
    )

    return <div className="line" style={style} >{items}</div>
  }
}

class Board extends React.Component {
  render() {

    var lines = this.props.data.split('\n')

    const items = lines.map((el, index) =>
      <Line key={index} data={el} />
    );

    return <div className="board">{items}</div>
  }
}

class Root extends React.Component {

  constructor(props) {
    super(props)
    this.state = {
      board: "11111\n00000"
    }

    this.props.channel.on("one_step", payload => {
      console.log('new message');
      console.log(payload);

      this.setState({board: payload.body})
    })

    this.step = this.step.bind(this)
  }

  step(e) {
    e.preventDefault()
    this.props.channel.push("one_step", {})
  }

  render() {
    return (
      <>
      <button id="step" onClick={this.step}>start</button>
       <Board data={this.state.board} />
       </>
    )
  }
}

export default Root;
