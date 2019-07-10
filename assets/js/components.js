import * as React from 'react';
import {Socket} from "phoenix"

class Case extends React.Component {
  render() {

    var style = {backgroundColor: 'green'}
    if (this.props.data === '.') {
      style = {backgroundColor: 'blue'}
    }

    return <td style={style} >{this.props.data}</td>
  }
}

class Line extends React.Component {
  render() {
    const elems = Array.from(this.props.data)

    const items = elems.map((el, index) =>
      <Case key={index} data={el} />
    )

    return <tr>{items}</tr>
  }
}

class Board extends React.Component {
  render() {

    var lines = this.props.data.split('\n')

    const items = lines.map((el, index) =>
      <Line key={index} data={el} />
    );

    return (
      <table>
        <tbody>
          {items}
        </tbody>
      </table>
    )
  }
}

class Root extends React.Component {

  constructor(props) {
    super(props)
    this.state = {
      board: ""
    }
  }

  componentDidMount() {
    this.connectWS()
  }

  connectWS() {
    let socket = new Socket("/socket", {})
    socket.connect()
    let channel = socket.channel("room:lobby", {})

    channel.join()
     .receive("ok", resp => { console.log("Joined successfully", resp) })
     .receive("error", resp => { console.log("Unable to join", resp) })

    channel.on("new_msg", payload => {
      this.setState({board: payload.body})
    })

    let chatInput = document.querySelector("#chat-input")
    chatInput.addEventListener("keypress", event => {
      if(event.keyCode === 13){
        channel.push("new_msg", {body: chatInput.value})
        chatInput.value = ""
      }
    })
  }


  render() {
    return (
       <Board data={this.state.board} />
    )
  }
}

export default Root;
