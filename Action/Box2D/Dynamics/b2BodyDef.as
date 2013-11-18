package Box2D.Dynamics
{
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;

    public class b2BodyDef extends Object
    {
        public var isSleeping:Boolean;
        public var position:b2Vec2;
        public var isBullet:Boolean;
        public var allowSleep:Boolean;
        public var userData:Object;
        public var angularDamping:Number;
        public var fixedRotation:Boolean;
        public var angle:Number;
        public var linearDamping:Number;
        public var massData:b2MassData;

        public function b2BodyDef()
        {
            massData = new b2MassData();
            position = new b2Vec2();
            massData.center.SetZero();
            massData.mass = 0;
            massData.I = 0;
            userData = null;
            position.Set(0, 0);
            angle = 0;
            linearDamping = 0;
            angularDamping = 0;
            allowSleep = true;
            isSleeping = false;
            fixedRotation = false;
            isBullet = false;
            return;
        }// end function

    }
}
