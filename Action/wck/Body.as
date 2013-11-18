package wck
{
    import Box2D.Dynamics.*;
    import flash.display.*;
    import flash.events.*;

    public class Body extends MovieClip
    {
        public var bodyIsStatic:Boolean = false;
        public var bodyAngularDamping:Number = 0;
        public var bodyIsSleeping:Boolean = false;
        public var bodyAllowSleep:Boolean = true;
        public var bodyFixedRotation:Boolean = false;
        public var bodyIsBullet:Boolean = false;
        public var world:World;
        public var bodyLinearDamping:Number = 0;
        public var b2body:b2Body;
        public var bodyApplyGravity:Boolean = true;

        public function Body()
        {
            bodyLinearDamping = 0;
            bodyAngularDamping = 0;
            bodyAllowSleep = true;
            bodyIsSleeping = false;
            bodyFixedRotation = false;
            bodyIsBullet = false;
            bodyApplyGravity = true;
            bodyIsStatic = false;
            return;
        }// end function

        public function create() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            world = parent as World;
            _loc_1 = new b2BodyDef();
            _loc_1.userData = this;
            _loc_1.linearDamping = bodyLinearDamping;
            _loc_1.angularDamping = bodyAngularDamping;
            _loc_1.allowSleep = bodyAllowSleep;
            _loc_1.isSleeping = bodyIsSleeping;
            _loc_1.fixedRotation = bodyFixedRotation;
            _loc_1.isBullet = bodyIsBullet;
            _loc_2 = rotation;
            rotation = 0;
            _loc_1.position.Set(x / world.scale, y / world.scale);
            _loc_1.angle = _loc_2 * Math.PI / 180;
            rotation = _loc_2;
            b2body = world.b2world.CreateBody(_loc_1);
            _loc_3 = this as Shape;
            if (_loc_3)
            {
                _loc_3.createShape();
            }
            _loc_4 = 0;
            while (_loc_4 < numChildren)
            {
                
                _loc_3 = getChildAt(_loc_4) as Shape;
                if (_loc_3)
                {
                    _loc_3.createShape();
                }
                _loc_4++;
            }
            if (!bodyIsStatic)
            {
                b2body.SetMassFromShapes();
            }
            world.addEventListener(Event.ENTER_FRAME, step, false, 0, true);
            world.addEventListener("cleanUp", cleanUp, false, 0, true);
            return;
        }// end function

        public function step(event:Event) : void
        {
            if (!world.paused)
            {
                x = b2body.GetPosition().x * world.scale;
                y = b2body.GetPosition().y * world.scale;
                rotation = b2body.GetAngle() * 180 / Math.PI % 360;
            }
            return;
        }// end function

        public function cleanUp(event:Event = null) : void
        {
            world.removeEventListener(Event.ENTER_FRAME, step);
            return;
        }// end function

    }
}
