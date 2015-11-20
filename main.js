var Box2d={
    b2Vec2 : Box2D.Common.Math.b2Vec2,
    b2BodyDef : Box2D.Dynamics.b2BodyDef,
    b2Body : Box2D.Dynamics.b2Body,
    b2FixtureDef : Box2D.Dynamics.b2FixtureDef,
    b2Fixture : Box2D.Dynamics.b2Fixture,
    b2World : Box2D.Dynamics.b2World,
    b2MassData : Box2D.Collision.Shapes.b2MassData,
    b2PolygonShape : Box2D.Collision.Shapes.b2PolygonShape,
    b2CircleShape : Box2D.Collision.Shapes.b2CircleShape,
    b2DebugDraw : Box2D.Dynamics.b2DebugDraw
 };
var Input={
	mousedown:false
	};
 var CATEGORY_PLAYER=0x001;
 var CATEGORY_BAT=0x002;
 var CATEGORY_BALL=0x004;
 var CATEGORY_GROUND=0x008;
 var WIDTH=document.getElementById("canvas").width;
 var HEIGHT;
var SCALE=30;
var stage,world,ground,
	headBody,rootBody,
	rHandUBody,rHandLBody,
	lHandUBody,lHandLBody,
	rLegUBody,rLegLBody,
	lLegUBody,lLegLBody
	,batBody,_mouseJoint,_mouseJoint2,ANGLE,currentBall;
var PI=3.141592653589793;
function init(){
	stage=new createjs.Stage(document.getElementById("canvas"));
	debug=document.getElementById("debug");

	setupPhysics();
	/////////////////////////Creating Body.........//////////////
	
	createBody();
	// Appyling Joints between to bodyparts;

	var joint_Head_Def=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	var joint_RHandU_Def=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	var joint_RHandL_Def=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();	
	var joint_LHandU_Def=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	var joint_LHandL_Def=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	var joint_RLegU_Def=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	var joint_RLegL_Def=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();	
	var joint_LLegU_Def=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	var joint_LLegL_Def=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	
	
/////////////////////////////Joints in body parts//////////////////////
	
	createJoint(joint_RLegU_Def,rootBody,rLegUBody,60,90,10,30);
	createJoint(joint_RLegL_Def,rLegUBody,rLegLBody,95,25,26,36,-PI/8,-PI/8);
	createJoint(joint_LLegU_Def,rootBody,lLegUBody,40,90,91,33,-PI/2,-PI/3);
	createJoint(joint_LLegL_Def,lLegUBody,lLegLBody,9,43,25,40,PI/2,PI);
	createJoint(joint_Head_Def,headBody,rootBody,10,50,50,10,0,PI/6);
	createJoint(joint_RHandU_Def,rootBody,rHandUBody,70,20,10,30,-PI/2,PI/2);
	createJoint(joint_RHandL_Def,rHandUBody,rHandLBody,95,25,10,10,0,PI/3);
	createJoint(joint_LHandU_Def,rootBody,lHandUBody,40,25,5,15,-PI/2,PI/2);
	createJoint(joint_LHandL_Def,lHandUBody,lHandLBody,85,20,7,10,-PI/2,-PI);
	
	var axies = new Box2d.b2Vec2(1.0,0);
	var anchor = new Box2d.b2Vec2(lLegLBody.GetPosition().x, lLegLBody.GetPosition().y+70/SCALE);
	var anchor2 = new Box2d.b2Vec2(rLegLBody.GetPosition().x,rLegLBody.GetPosition().y+70/SCALE);
	var joint_ground_l = new Box2D.Dynamics.Joints.b2LineJointDef();
	joint_ground_l.Initialize(ground, lLegLBody, anchor, axies);
	joint_ground_l.lowerTranslation = -1.0;
	joint_ground_l.upperTranslation = 1.0;
	joint_ground_l.enableLimit = true;
	joint_ground_l.enableMotor = false;
	world.CreateJoint(joint_ground_l);
	
	var joint_ground_r = new Box2D.Dynamics.Joints.b2PrismaticJointDef();
	joint_ground_r.Initialize(ground, rLegLBody, anchor2, axies);
	joint_ground_r.lowerTranslation = -0.5;
	joint_ground_r.upperTranslation = 1.5;
	joint_ground_r.enableLimit = true;
	joint_ground_r.enableMotor = false;
	world.CreateJoint(joint_ground_r);
	
	//var joint_ground_l=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	//var joint_ground_r=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	//createJoint(joint_ground_l,ground,lLegLBody,100,0,29,171,PI/6,PI/2.5);
	//createJoint(joint_ground_r,ground,rLegLBody,(WIDTH/10)*3,0,29,171,-PI/6,PI/7);
	
	
	var joint_bat_l=new  Box2D.Dynamics.Joints.b2RevoluteJointDef()
		joint_bat_r=new  Box2D.Dynamics.Joints.b2RevoluteJointDef();
	createJoint(joint_bat_r,batBody,rHandLBody,10,10,20,75,-PI/2,0);
	createJoint(joint_bat_l,batBody,lHandLBody,10,25,85,15,-PI/2,0);//,-PI/2,0);
		
		
		
	stage.addEventListener("stagemouseup", function(e){
	Input.mousedown=false;
	
	},false);
	stage.onMouseDown= function(e){
		Input.mousedown=true;
		var b=new Ball();
		stage.addChild(b.view);
		currentBall=b.view.body;
		var randomPitch=((2*WIDTH/10)+(1.8*WIDTH))*Math.random()/SCALE;
		var direction=new Box2d.b2Vec2(randomPitch-currentBall.GetPosition().x,
							 ((3*HEIGHT/4)/SCALE)-currentBall.GetPosition().y);
		var magnitute=Math.sqrt(direction.x*direction.x
								+direction.y*direction.y);
		 direction=new Box2d.b2Vec2(direction.x/magnitute,
										direction.y/magnitute);
		
		currentBall.ApplyImpulse(new Box2d.b2Vec2(currentBall.GetMass()*SCALE*direction.x,currentBall.GetMass()*SCALE*direction.y),currentBall.GetPosition());
	};
	 
/*
	var md = new Box2D.Dynamics.Joints.b2MouseJointDef();
	md.bodyA = world.GetGroundBody();
	md.bodyB = headBody;
	md.target.Set(800/SCALE,0/SCALE);
	md.maxForce = 1500.0 * headBody.GetMass();
    world.CreateJoint(md);
*/


	///////////////////////
	createjs.Ticker.addListener(this);
	createjs.Ticker.setFPS(60);
	createjs.Ticker.useRAF=false;
		

}

function createBody(){
var head=new createjs.Bitmap("img/Head.png");head.regX=32;head.regY=34;
var root=new createjs.Bitmap("img/root.png");root.regX=41;root.regY=52
//Hands
var rHandU=new createjs.Bitmap("img/RHandU.png");rHandU.regX=53;rHandU.regY=25;
var rHandL=new createjs.Bitmap("img/RHandL.png");rHandL.regX=15;rHandL.regY=46;
var lHandU=new createjs.Bitmap("img/LHandU.png");lHandU.regX=43;lHandU.regY=18;
var lHandL=new createjs.Bitmap("img/LHandL.png");lHandL.regX=50;lHandL.regY=16;
//Legs
var rLegU=new createjs.Bitmap("img/RLegU.png");rLegU.regX=53;rLegU.regY=25;
var rLegL=new createjs.Bitmap("img/RLegL.png");rLegL.regX=26;rLegL.regY=90;
var lLegU=new createjs.Bitmap("img/LLegU.png");lLegU.regX=70;lLegU.regY=30;
var lLegL=new createjs.Bitmap("img/LLegL.png");lLegL.regX=26;lLegL.regY=90;
///////////////////// Bat ///////////////////////////////////

var centerX=500;var centerY=200;

 headBody=buidlBodyParts(64,68,centerX,centerY);
 rootBody=buidlBodyParts(82,104,centerX,centerY);
 rHandUBody=buidlBodyParts(107,51,centerX,centerY); rHandLBody=buidlBodyParts(31,92,centerX,centerY);
 lHandUBody=buidlBodyParts(87,36,centerX,centerY); lHandLBody=buidlBodyParts(101,32,centerX,centerY);
 rLegUBody=buidlBodyParts(107,51,centerX,centerY); rLegLBody=buidlBodyParts(53,181,(WIDTH/10)*3,3*HEIGHT/4-70);
 rLegLBody.SetPositionAndAngle(rLegLBody.GetPosition(),PI/8);
 lLegUBody=buidlBodyParts(140,60,centerX,centerY); lLegLBody=buidlBodyParts(53,181,(WIDTH/10)*2,3*HEIGHT/4-70);
  
buildTick(root,rootBody);
buildTick(head,headBody);
buildTick(rHandU,rHandUBody);buildTick(rHandL,rHandLBody);
buildTick(lHandU,lHandUBody);buildTick(lHandL,lHandLBody);
buildTick(rLegU,rLegUBody);buildTick(rLegL,rLegLBody);
buildTick(lLegU,lLegUBody);buildTick(lLegL,lLegLBody);
//////////////////// bat
 var bat=new createjs.Bitmap("img/bat.png");bat.regX=12;bat.regY=89;
batBody=buildBat(24,178,200,centerY); 
buildTick(bat,batBody);
//////////////////////////// 

stage.addChild(rLegU);stage.addChild(rLegL);
stage.addChild(lLegU);stage.addChild(lLegL);
stage.addChild(bat);
stage.addChild(rHandU);stage.addChild(rHandL);
stage.addChild(root);
stage.addChild(head);
stage.addChild(lHandU);stage.addChild(lHandL);


}

function buildBat(width,height,x,y,image){

var fixDef=new Box2d.b2FixtureDef();
fixDef.density=1;
fixDef.friction=3;
fixDef.restitution=0.0;
fixDef.filter.categoryBits =CATEGORY_BAT;
fixDef.filter.maskBits= CATEGORY_BALL|CATEGORY_GROUND;

var bodyDef=new Box2d.b2BodyDef();
bodyDef.type = Box2d.b2Body.b2_dynamicBody;
bodyDef.position.x=x/SCALE;
bodyDef.position.y=y/SCALE;

fixDef.shape=new Box2d.b2PolygonShape();
fixDef.shape.SetAsBox(width/2/SCALE,height/2/SCALE);
var body=world.CreateBody(bodyDef);
body.CreateFixture(fixDef);
return body;
}

function buidlBodyParts(width,height,x,y,image){

var fixDef=new Box2d.b2FixtureDef();
fixDef.density=1;
fixDef.friction=10;
fixDef.restitution=0.0;
fixDef.filter.categoryBits =CATEGORY_PLAYER;
fixDef.filter.maskBits= CATEGORY_GROUND;

var bodyDef=new Box2d.b2BodyDef();
bodyDef.type = Box2d.b2Body.b2_dynamicBody;
bodyDef.position.x=x/SCALE;
bodyDef.position.y=y/SCALE;

fixDef.shape=new Box2d.b2PolygonShape();
fixDef.shape.SetAsBox(width/2/SCALE,height/2/SCALE);
var body=world.CreateBody(bodyDef);
body.CreateFixture(fixDef);
return body;
}

function buildTick(image,body){
image.onTick=function (e){

image.x=body.GetPosition().x*SCALE;
image.y=body.GetPosition().y*SCALE;
image.rotation=body.GetAngle()*(180/Math.PI);
}
}

function createJoint(bodyjoint,body,body2,x,y,x2,y2,la,ua){
	bodyjoint.Initialize(body, body2,0);
	var shape=body.GetFixtureList().GetShape();
	
	var centerx=((shape.m_vertices [2].x-shape.m_vertices [3].x)/2);
	var centery=((shape.m_vertices [2].y-shape.m_vertices [1].y)/2);
	var shape2=body2.GetFixtureList().GetShape();
	var centerx2=((shape2.m_vertices [2].x-shape2.m_vertices [3].x)/2);
	var centery2=((shape2.m_vertices [2].y-shape2.m_vertices [1].y)/2);
	bodyjoint.enableLimit = true;
	bodyjoint.localAnchorA=new Box2d.b2Vec2(x/SCALE-centerx,y/SCALE-centery);
	bodyjoint.localAnchorB=new Box2d.b2Vec2(x2/SCALE-centerx2,y2/SCALE-centery2);
	if(!la && la>0)
	la=0;
	if(!ua && ua>0)
	ua=2*PI;
	bodyjoint.lowerAngle=la;
	bodyjoint.upperAngle=ua;
	
	bodyjoint.collideConnected = true;
	//sbodyjoint.enableMotor = false;
	
	world.CreateJoint(bodyjoint);
	
}

function setupPhysics(){
	world=new Box2d.b2World(new Box2d.b2Vec2(0,10),true);
	//create pitch ..ground;
	var fixDef=new Box2d.b2FixtureDef();
	fixDef.density=1;
	fixDef.friction=0.5;
	fixDef.filter.categoryBits =CATEGORY_GROUND;
	fixDef.filter.maskBits =CATEGORY_PLAYER|CATEGORY_BALL;
	WIDTH=document.getElementById("canvas").width;
	HEIGHT=document.getElementById("canvas").height;
	
	var bodyDef=new Box2d.b2BodyDef();
	bodyDef.type = Box2d.b2Body.b2_staticBody;
	bodyDef.position.x=WIDTH/2/SCALE;
	bodyDef.position.y=HEIGHT/SCALE;
	fixDef.shape=new Box2d.b2PolygonShape();
	fixDef.shape.SetAsBox((WIDTH/2)/SCALE,(HEIGHT/4)/SCALE);
	ground=world.CreateBody(bodyDef);
	ground.CreateFixture(fixDef);
	//setup debug draw
	var debugDraw=new Box2d.b2DebugDraw();
	debugDraw.SetSprite(debug.getContext('2d'));
	debugDraw.SetDrawScale(SCALE);
	debugDraw.SetFillAlpha(0.6);
	debugDraw.SetFlags(Box2d.b2DebugDraw.e_shapeBit|Box2d.b2DebugDraw.e_jointBit);
	world.SetDebugDraw(debugDraw);
	
}
 
function GetBodyAtMouse(includeStatic )
{
if(!includeStatic)
includeStatic=false;
   var  _mousePVec=new Box2d.b2Vec2(stage.mouseX/SCALE,stage.mouseY/SCALE);
	var aabb = new Box2D.Collision.b2AABB();
    aabb.lowerBound.Set(stage.mouseX/SCALE - 0.001, stage.mouseY/SCALE - 0.001);
    aabb.upperBound.Set(stage.mouseX/SCALE + 0.001, stage.mouseY/SCALE + 0.001);
    var body;
    var fixture;

    // Query the world for overlapping shapes.
    function GetBodyCallback(fixture)
    {
    var shape = fixture.GetShape();
        if (fixture.GetBody().GetType() != Box2d.b2Body.b2_staticBody || includeStatic)
        {
            var inside = shape.TestPoint(fixture.GetBody().GetTransform(), _mousePVec);
            if (inside)
            {
                body = fixture.GetBody();
                return false;
            }
        }
        return true;
    }
    world.QueryAABB(GetBodyCallback, aabb);
    return body;
}

function mouseDrag(){
	
	if (!_mouseJoint )
   {
	
	var body = batBody;
	var md = new Box2D.Dynamics.Joints.b2MouseJointDef();
	md.bodyA = world.GetGroundBody();
	md.bodyB = body;
	md.target.Set(batBody.GetWorldCenter().x,batBody.GetWorldCenter().y+90/SCALE);
	md.collideConnected = true;
	md.maxForce = 100.0 * body.GetMass();
    _mouseJoint = world.CreateJoint(md);
	body.SetAwake(true);
	
    }
	
	if (_mouseJoint)
	{

        _mouseJoint.SetTarget( new Box2d.b2Vec2(stage.mouseX/SCALE,stage.mouseY/SCALE));
	}

}

function mouseDrag2(){
	
	if (!_mouseJoint2)
   {
	
	var body = rootBody;
	var md = new Box2D.Dynamics.Joints.b2MouseJointDef();
	md.bodyA = world.GetGroundBody();
	md.bodyB = body;
	md.target.Set(rootBody.GetPosition().x,rootBody.GetPosition().y);
	md.collideConnected = true;
	md.maxForce = 5000.0 * body.GetMass();
    _mouseJoint = world.CreateJoint(md);
	body.SetAwake(true);
	
    }
	
	if (_mouseJoint)
	{

        _mouseJoint2.SetTarget( new Box2d.b2Vec2(stage.mouseX/SCALE,stage.mouseY/SCALE));
	}

}

function MouseDrag(){
	
	if (!_mouseJoint && Input.mousedown==true)
   {
   var body = GetBodyAtMouse();
	
    if (body){
	var md = new Box2D.Dynamics.Joints.b2MouseJointDef();
	md.bodyA = world.GetGroundBody();
	md.bodyB = body;
	md.target.Set(stage.mouseX/SCALE,stage.mouseY/SCALE);
	md.collideConnected = true;
	md.maxForce = 5000.0 * body.GetMass();
    _mouseJoint = world.CreateJoint(md);
	body.SetAwake(true);
	
    }
	}
	if(Input.mousedown==false)
	{if (_mouseJoint)
     {
            world.DestroyJoint(_mouseJoint);
			var temp;
            _mouseJoint =temp ;
     }
	 }
	if (_mouseJoint)
	{

        _mouseJoint.SetTarget( new Box2d.b2Vec2(stage.mouseX/SCALE,stage.mouseY/SCALE));
	}

}

function tick(){
	stage.update();
	
	world.DrawDebugData();
	if(currentBall){
	ANGLE=Math.atan((headBody.GetPosition().y-currentBall.GetPosition().y)
					/(headBody.GetPosition().x-currentBall.GetPosition().x));
	headBody.SetPositionAndAngle(headBody.GetPosition(),ANGLE);
	}
	if(stage.mouseX>(WIDTH/10) && stage.mouseX<(WIDTH/1.75)  )
	mouseDrag();
	world.Step(1/60,10,10);
	
	

	world.ClearForces();
}



