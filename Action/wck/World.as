package wck
{
    import Box2D.Collision.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import flash.display.*;
    import flash.events.*;

    public class World extends MovieClip
    {
        public var lshoulder:LeftShoulder;
        public var gravityRadial:Number = 0;
        public var rshoulder:RightShoulder;
        public var bat:Bat;
        public var vars:Object;
        public var keepCenteredOn:String = "";
        public var z4_a:zone_4a;
        public var z4_b:zone_4b;
        public var boundsTop:Number = 1e+010;
        public var boundsLeft:Number = -1e+010;
        public var boundsRight:Number = 1e+010;
        public var larm:LeftArm;
        public var bleg:BackLeg;
        public var viewtarget:MovieClip;
        public var rarm:RightArm;
        public var z2_a:zone_2a;
        public var wicket:Wicket;
        public var bthigh:BackThigh;
        public var chest:Chest;
        public var doSleep:Boolean = true;
        public var centerOn:DisplayObject;
        public var z1_a:zone_1a;
        public var paused:Boolean;
        public var iterations:int = 10;
        public var timeStep:Number = 0.025;
        public var boundsBottom:Number = -1e+010;
        public var scale:Number = 40;
        public var fthigh:FrontThigh;
        public var groundart:Ground;
        public var b2world:b2World;
        public var ground:GroundBox;
        public var bail:Bail;
        public var gravityX:Number = 0;
        public var gravityY:Number = 10;
        public var zo_a:zone_outa;
        public var zo_b:zone_outb;
        public var z6_a:zone_6a;
        public var z6_c:zone_6c;
        public var z6_b:zone_6b;
        public var head:Head;
        public var fleg:FrontLeg;

        public function World()
        {
            timeStep = 0.025;
            iterations = 10;
            boundsTop = 10000000000;
            boundsLeft = -10000000000;
            boundsBottom = -10000000000;
            boundsRight = 10000000000;
            gravityX = 0;
            gravityY = 10;
            gravityRadial = 0;
            doSleep = true;
            scale = 40;
            keepCenteredOn = "";
            vars = {};
            return;
        }// end function

        public function cleanUp() : void
        {
            dispatchEvent(new Event("cleanUp"));
            removeEventListener(Event.ENTER_FRAME, step);
            return;
        }// end function

        public function step(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!paused)
            {
                b2world.Step(timeStep, iterations);
                GlobalVars.vars.timeElapsed = GlobalVars.vars.timeElapsed + timeStep;
                if (gravityRadial)
                {
                    _loc_4 = b2world.GetBodyList();
                    while (_loc_4)
                    {
                        
                        if (!_loc_4.IsStatic() && !_loc_4.IsSleeping())
                        {
                            _loc_2 = _loc_4.GetWorldCenter().Copy();
                            _loc_2.Normalize();
                            _loc_2.Multiply(gravityRadial);
                            _loc_3 = _loc_4.GetLinearVelocity();
                            _loc_3.x = _loc_3.x + timeStep * _loc_2.x;
                            _loc_3.y = _loc_3.y + timeStep * _loc_2.y;
                        }
                        _loc_4 = _loc_4.GetNext();
                    }
                }
            }
            if (centerOn)
            {
                x = -centerOn.x;
                y = -centerOn.y;
            }
            return;
        }// end function

        public function create() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            _loc_1 = new b2AABB();
            _loc_1.lowerBound.Set(boundsLeft, boundsBottom);
            _loc_1.upperBound.Set(boundsRight, boundsTop);
            b2world = new b2World(_loc_1, new b2Vec2(gravityX, gravityY), doSleep);
            b2world.SetContactListener(new ContactListener());
            _loc_4 = [];
            _loc_5 = 0;
            while (_loc_5 < numChildren)
            {
                
                var _loc_6:* = getChildAt(_loc_5) as Body;
                _loc_2 = getChildAt(_loc_5) as Body;
                if (_loc_6)
                {
                    _loc_2.create();
                }
                else
                {
                    var _loc_6:* = getChildAt(_loc_5) as Joint;
                    _loc_3 = getChildAt(_loc_5) as Joint;
                    if (_loc_6)
                    {
                        _loc_3.anchor();
                        _loc_4.push(_loc_3);
                    }
                }
                _loc_5++;
            }
            for each (_loc_3 in _loc_4)
            {
                
                _loc_3.create();
            }
            if (keepCenteredOn)
            {
                centerOn = getChildByName(keepCenteredOn);
            }
            addEventListener(Event.ENTER_FRAME, step, false, 0, true);
            return;
        }// end function

        public function setVar(param1:String, param2)
        {
            vars[param1] = param2;
            dispatchEvent(new Event(param1));
            return;
        }// end function

    }
}
