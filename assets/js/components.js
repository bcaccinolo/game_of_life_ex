import * as React from 'react';
import {Socket} from "phoenix"

class Case extends React.Component {
  render() {
    var style = {
      backgroundColor: 'black',
      border: '1px solid gray',
      width: '7px',
      height: '7px'
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
      board: "11111\n00000",
      loopId: null
    }

    this.props.channel.on("one_step", payload => {
      console.log('new message');
      console.log(payload);

      this.setState({board: payload.body})
    })

    this.step = this.step.bind(this)
    this.start = this.start.bind(this)
    this.stop = this.stop.bind(this)
  }

  step(e) {
    e.preventDefault()
    this.props.channel.push("one_step", {})
  }

  start(e) {
    e.preventDefault()
    let loopId = setInterval(function(){ this.props.channel.push("one_step", {}) }.bind(this), 300)
    this.setState({loopId: loopId})
  }

  stop(e) {
    e.preventDefault()
    if(this.state != null){
      clearInterval(this.state.loopId)
      this.setState({loopId: null})
    }
  }

  render() {
    return (
      <>
      <button id="step" onClick={this.step}>step</button>
      <button id="start" onClick={this.start}>start</button>
      <button id="stop" onClick={this.stop}>stop</button>
       <Board data={this.state.board} />
       </>
    )
  }
}

export default Root;
