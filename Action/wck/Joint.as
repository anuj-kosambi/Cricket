package wck
{
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Joints.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Joint extends MovieClip
    {
        public var spring:Boolean = false;
        public var positionInBody:Point;
        public var lineParameter:String = "0x888888";
        public var lineStyle:String = "Line";
        public var springDamping:Number = 0;
        public var upperLimit:Number = 0;
        public var strength:Number = 0;
        public var speed:Number = 0;
        public var collideConnected:Boolean = false;
        public var pathReturns:Boolean = true;
        public var speedFlag:Object = "";
        public var target:Joint;
        public var world:World;
        public var lowerLimit:Number = 0;
        public var bodyName:String = "";
        public var body2Name:String = "";
        public var type:String = "None";
        public var body:Body;
        public var joint:b2Joint;
        public var enableMotor:Boolean = false;
        public var b2body:b2Body;
        public var speed1:Number = 0;
        public var b2body2:b2Body;
        public var body2:Body;
        public var springConstant:Number = 0;
        public var speed2:Number = 0;
        public var targetName:String = "";
        public var length:Number;
        public var lineMC:MovieClip;
        public var lineColor:Number;
        public var enableLimit:Boolean = false;

        public function Joint()
        {
            collideConnected = false;
            lowerLimit = 0;
            upperLimit = 0;
            strength = 0;
            speed1 = 0;
            speed2 = 0;
            enableLimit = false;
            enableMotor = false;
            targetName = "";
            type = "None";
            speedFlag = "";
            bodyName = "";
            body2Name = "";
            pathReturns = true;
            lineStyle = "Line";
            lineParameter = "0x888888";
            spring = false;
            springConstant = 0;
            springDamping = 0;
            speed = 0;
            return;
        }// end function

        public function setSpeed(event:Event) : void
        {
            speed = world.vars[speedFlag] ? (speed2) : (speed1);
            if (type == "Prismatic")
            {
                (joint as b2PrismaticJoint).SetMotorSpeed(speed);
            }
            else if (type == "Revolute" || type == "RevolutePin")
            {
                (joint as b2RevoluteJoint).SetMotorSpeed(speed);
            }
            b2body.WakeUp();
            if (b2body2)
            {
                b2body2.WakeUp();
            }
            return;
        }// end function

        public function create() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            switch(type)
            {
                case "Distance":
                {
                    _loc_1 = new b2DistanceJointDef();
                    _loc_1.Initialize(b2body, target.b2body, new b2Vec2(x / world.scale, y / world.scale), new b2Vec2(target.x / world.scale, target.y / world.scale));
                    joint = world.b2world.CreateJoint(_loc_1);
                    break;
                }
                case "Revolute":
                {
                    _loc_2 = new b2RevoluteJointDef();
                    _loc_2.Initialize(b2body, target.b2body, new b2Vec2(x / world.scale, y / world.scale));
                    _loc_2.lowerAngle = lowerLimit;
                    _loc_2.upperAngle = upperLimit;
                    _loc_2.maxMotorTorque = strength;
                    _loc_2.enableLimit = enableLimit;
                    _loc_2.enableMotor = enableMotor;
                    joint = world.b2world.CreateJoint(_loc_2);
                    break;
                }
                case "Prismatic":
                {
                    _loc_3 = new b2PrismaticJointDef();
                    _loc_4 = new b2Vec2((target.x - x) / world.scale, (target.y - y) / world.scale);
                    _loc_4.Normalize();
                    _loc_3.Initialize(b2body, target.b2body, new b2Vec2(x / world.scale, y / world.scale), _loc_4);
                    _loc_3.lowerTranslation = lowerLimit / world.scale;
                    _loc_3.upperTranslation = upperLimit / world.scale;
                    _loc_3.maxMotorForce = strength;
                    _loc_3.enableLimit = enableLimit;
                    _loc_3.enableMotor = enableMotor;
                    joint = world.b2world.CreateJoint(_loc_3);
                    break;
                }
                case "RevolutePin":
                {
                    _loc_5 = new b2RevoluteJointDef();
                    _loc_5.Initialize(b2body, b2body2, new b2Vec2(x / world.scale, y / world.scale));
                    _loc_5.lowerAngle = lowerLimit;
                    _loc_5.upperAngle = upperLimit;
                    _loc_5.maxMotorTorque = strength;
                    _loc_5.enableLimit = enableLimit;
                    _loc_5.enableMotor = enableMotor;
                    joint = world.b2world.CreateJoint(_loc_5);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (speedFlag != "")
            {
                world.addEventListener(speedFlag, setSpeed, false, 0, true);
            }
            setSpeed(null);
            if (lineStyle == "Line")
            {
                lineColor = parseInt(lineParameter);
            }
            else if (lineStyle == "MovieClip")
            {
                _loc_6 = getDefinitionByName(lineParameter) as Class;
                lineMC = new _loc_6;
                addChild(lineMC);
            }
            world.addEventListener(Event.ENTER_FRAME, step, false, 0, true);
            world.addEventListener("cleanUp", cleanUp, false, 0, true);
            return;
        }// end function

        public function anchor() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            rotation = 0;
            world = parent as World;
            _loc_1 = localToGlobal(new Point(0, 0));
            if (bodyName)
            {
                body = world.getChildByName(bodyName) as Body;
            }
            if (body2Name)
            {
                body2 = world.getChildByName(body2Name) as Body;
            }
            if (!body || type == "RevolutePin" && !body2)
            {
                _loc_2 = world.getObjectsUnderPoint(world.globalToLocal(_loc_1));
                _loc_3 = null;
                for each (_loc_4 in _loc_2)
                {
                    
                    _loc_3 = null;
                    while (_loc_4 && !_loc_3)
                    {
                        
                        _loc_3 = _loc_4 as Shape;
                        _loc_4 = _loc_4.parent;
                    }
                    if (_loc_3)
                    {
                        if (!body)
                        {
                            body = _loc_3.body;
                            if (type != "RevolutePin" || body2)
                            {
                                break;
                            }
                            continue;
                        }
                        if (_loc_3.body != body)
                        {
                            body2 = _loc_3.body;
                            break;
                        }
                    }
                }
            }
            b2body = body ? (body.b2body) : (world.b2world.m_groundBody);
            if (type == "RevolutePin")
            {
                b2body2 = body2 ? (body2.b2body) : (world.b2world.m_groundBody);
            }
            else
            {
                target = parent.getChildByName(targetName) as Joint;
            }
            if (body)
            {
                positionInBody = body.globalToLocal(_loc_1);
            }
            return;
        }// end function

        public function cleanUp(event:Event)
        {
            world.removeEventListener(Event.ENTER_FRAME, step);
            return;
        }// end function

        public function step(event:Event) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (world.paused)
            {
                return;
            }
            if (spring)
            {
                if (type == "Prismatic")
                {
                    _loc_3 = joint as b2PrismaticJoint;
                    _loc_2 = _loc_3.GetJointTranslation();
                    _loc_3.SetMaxMotorForce(Math.abs(_loc_2 * springConstant + _loc_3.GetJointSpeed() * springDamping));
                    _loc_3.SetMotorSpeed(_loc_2 > 0 ? (-1000000) : (1000000));
                }
                else if (type == "Revolute" || type == "RevolutePin")
                {
                    _loc_4 = joint as b2RevoluteJoint;
                    _loc_2 = _loc_4.GetJointAngle();
                    _loc_4.SetMaxMotorTorque(Math.abs(_loc_2 * springConstant + _loc_4.GetJointSpeed() * springDamping));
                    _loc_4.SetMotorSpeed(_loc_2 > 0 ? (-1000000) : (1000000));
                }
            }
            if (body)
            {
                _loc_5 = world.globalToLocal(body.localToGlobal(positionInBody));
                x = _loc_5.x;
                y = _loc_5.y;
            }
            return;
        }// end function

    }
}
