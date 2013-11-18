package wck
{
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class Cursor extends MovieClip
    {
        public var bat:Bat;
        public var joint:b2MouseJoint;
        public var world:World;
        public var shape:Shape;

        public function Cursor()
        {
            return;
        }// end function

        public function position(event:MouseEvent) : void
        {
            x = event.stageX;
            y = event.stageY;
            return;
        }// end function

        public function lock()
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            stage.removeEventListener(Event.ENTER_FRAME, updateJoint);
            if (world && !world.paused)
            {
                shape = world.getChildByName("bat") as Bat;
                _loc_1 = world.globalToLocal(new Point(x, y));
                if (shape)
                {
                    _loc_2 = new b2MouseJointDef();
                    _loc_2.body1 = world.b2world.m_groundBody;
                    _loc_2.body2 = shape.body.b2body;
                    _loc_2.target = new b2Vec2(-102 / world.scale, 121 / world.scale);
                    _loc_2.maxForce = 200 * shape.body.b2body.m_mass;
                    _loc_2.timeStep = 1 / 40;
                    joint = world.b2world.CreateJoint(_loc_2) as b2MouseJoint;
                    stage.addEventListener(Event.ENTER_FRAME, updateJoint, false, 0, true);
                }
            }
            return;
        }// end function

        public function updateJoint(event:Event) : void
        {
            var _loc_2:* = null;
            _loc_2 = world.globalToLocal(new Point(x, y));
            joint.SetTarget(new b2Vec2(_loc_2.x / world.scale, _loc_2.y / world.scale));
            return;
        }// end function

        public function initialize()
        {
            mouseEnabled = false;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, position, false, 0, true);
            return;
        }// end function

    }
}
