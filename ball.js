(function(window){



	function Ball(){
	this.view=new createjs.Bitmap("Ball.png");
	
	this.view.regX=this.view.regY=15;

	var fixDef=new Box2d.b2FixtureDef();
	fixDef.density=1;
	fixDef.friction=0.5;
	fixDef.restitution=1;
	fixDef.filter.categoryBits =CATEGORY_BALL;
	fixDef.filter.maskBits= CATEGORY_BAT|CATEGORY_GROUND|CATEGORY_BALL;
	var bodyDef=new Box2d.b2BodyDef();
	bodyDef.type = Box2d.b2Body.b2_dynamicBody;
	bodyDef.position.x=WIDTH/SCALE;
	bodyDef.position.y=((2*HEIGHT/3)*Math.random())/SCALE;
	fixDef.shape=new Box2d.b2CircleShape(15/SCALE);
	
	this.view.body=world.CreateBody(bodyDef);
	this.view.body.CreateFixture(fixDef);
	
	
	this.view.onTick=tick;
	
	}
	function tick(e){
		this.x=this.body.GetPosition().x*SCALE;
		this.y=this.body.GetPosition().y*SCALE;
		
		
		this.rotation=this.body.GetAngle()*(180/Math.PI);
	}
	
	
	window.Ball=Ball;
})(window);