var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

carouselData = [
  {
    title: "MapBiomas",
    caption: "Lorem ipsum",
    body: "Lorem ipsum ipsum",
    image: "assets/images/mapbiomas.png",
    link: "http://mapbiomas.org"
  },
  {
    title: "SEEG",
    caption: "Lorem ipsum",
    body: "Lorem ipsum ipsum",
    image: "assets/images/seeg.png",
    link: "http://plataforma.seeg.eco.org"
  }

];

var Carousel = React.createClass({
  getInitialState: function() {
    return {
      currentIndex: 0
    };
  },

  componentDidMount: function() {
    this.interval = setInterval(function() {
      this.next();
    }.bind(this), 3000);
  },

  componentWillUnmount: function() {
    clearInterval(this.interval);
  },

  next: function() {
    var nextIndex = this.state.currentIndex + 1;
    var lastIndex = carouselData.length - 1;
    if(nextIndex > lastIndex) {
      nextIndex = 0;
    }
    this.setState({ currentIndex: nextIndex });
  },

  render: function() {
    var currentItem = carouselData[this.state.currentIndex];
    return (
      <div>
        <ReactCSSTransitionGroup transitionName="carousel" transitionEnterTimeout={300} transitionLeaveTimeout={300}>
          <div key={this.state.currentIndex} className="carousel-item">
            <img src={currentItem.image} />
            <h2 className="carousel-item-title">
              {currentItem.title}
            </h2>
            {currentItem.caption}
          </div>
        </ReactCSSTransitionGroup>
      </div>
    )
  }
})

window.onload = function() {
  ReactDOM.render(<Carousel />, $('.js-work-carousel')[0]);
}
