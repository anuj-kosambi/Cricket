package wck
{
    import flash.display.*;
    import flash.media.*;

    public class Ball extends Circle
    {
        public var score_added:Boolean = false;
        public var ball_hit:Boolean = false;
        public var luma_layer:MovieClip;

        public function Ball()
        {
            score_added = false;
            ball_hit = false;
            ball_hit = false;
            score_added = false;
            addEventListener("addContact", contactAdded, false, 0, true);
            return;
        }// end function

        public function contactAdded(param1:Contact) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = undefined;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = undefined;
            var _loc_19:* = null;
            _loc_2 = param1.cp.shape1.GetUserData();
            _loc_3 = param1.cp.shape2.GetUserData();
            if (ball_hit == false)
            {
                if (_loc_2.name == "bat" && _loc_3.name == "cball")
                {
                    ball_hit = true;
                    _loc_4 = new Thud_sound();
                    _loc_5 = _loc_4.play();
                }
            }
            if (_loc_2.name == "ground" && _loc_3.name == "cball")
            {
                _loc_6 = new Bump_sound();
                _loc_5 = _loc_6.play();
            }
            if (GlobalVars.vars.GameOver == false)
            {
                if (score_added == false && ball_hit == true)
                {
                    if (_loc_2.name == "cball" && _loc_3.name == "cball")
                    {
                        _loc_2.ball_hit = true;
                        _loc_3.ball_hit = true;
                    }
                    if (_loc_2.name == "z1_a" && _loc_3.name == "cball")
                    {
                        (GlobalVars.vars.score + 1);
                        score_added = true;
                        GlobalVars.vars.BallPlayedCount = GlobalVars.vars.BallCount;
                        _loc_7 = new Chime1();
                        _loc_5 = _loc_7.play();
                        _loc_8 = new Burst_1();
                        _loc_8.x = this.x;
                        _loc_8.y = this.y;
                        _loc_8.height = 70;
                        _loc_8.width = 70;
                        world.addChild(_loc_8);
                        removeEventListener("addContact", contactAdded);
                        _loc_9 = this.b2body.GetShapeList();
                        this.b2body.DestroyShape(_loc_9);
                        parent.removeChild(this);
                    }
                    else if (_loc_2.name == "z2_a" && _loc_3.name == "cball")
                    {
                        GlobalVars.vars.score = GlobalVars.vars.score + 2;
                        score_added = true;
                        GlobalVars.vars.BallPlayedCount = GlobalVars.vars.BallCount;
                        _loc_10 = new Chime2();
                        _loc_5 = _loc_10.play();
                        _loc_11 = new Burst_2();
                        _loc_11.x = this.x;
                        _loc_11.y = this.y;
                        _loc_11.height = 70;
                        _loc_11.width = 70;
                        world.addChild(_loc_11);
                        removeEventListener("addContact", contactAdded);
                        _loc_9 = this.b2body.GetShapeList();
                        this.b2body.DestroyShape(_loc_9);
                        parent.removeChild(this);
                    }
                    else if ((_loc_2.name == "z4_a" || _loc_2.name == "z4_b") && _loc_3.name == "cball")
                    {
                        GlobalVars.vars.score = GlobalVars.vars.score + 4;
                        score_added = true;
                        GlobalVars.vars.BallPlayedCount = GlobalVars.vars.BallCount;
                        _loc_12 = new Chime4();
                        _loc_5 = _loc_12.play();
                        _loc_13 = new Burst_4();
                        _loc_13.x = this.x;
                        _loc_13.y = this.y;
                        _loc_13.height = 70;
                        _loc_13.width = 70;
                        world.addChild(_loc_13);
                        removeEventListener("addContact", contactAdded);
                        _loc_9 = this.b2body.GetShapeList();
                        this.b2body.DestroyShape(_loc_9);
                        parent.removeChild(this);
                    }
                    else if ((_loc_2.name == "z6_a" || _loc_2.name == "z6_b" || _loc_2.name == "z6_c") && _loc_3.name == "cball")
                    {
                        GlobalVars.vars.score = GlobalVars.vars.score + 6;
                        score_added = true;
                        GlobalVars.vars.BallPlayedCount = GlobalVars.vars.BallCount;
                        removeEventListener("addContact", contactAdded);
                        _loc_14 = new Chime6();
                        _loc_5 = _loc_14.play();
                        _loc_15 = new Burst_6();
                        _loc_15.x = this.x;
                        _loc_15.y = this.y;
                        _loc_15.height = 70;
                        _loc_15.width = 70;
                        world.addChild(_loc_15);
                        _loc_9 = this.b2body.GetShapeList();
                        this.b2body.DestroyShape(_loc_9);
                        parent.removeChild(this);
                    }
                }
                if (score_added == false)
                {
                    if ((_loc_2.name == "zo_a" || _loc_2.name == "zo_b") && _loc_3.name == "cball")
                    {
                        if (ball_hit == true)
                        {
                            GlobalVars.vars.GameOver = true;
                            score_added = true;
                            GlobalVars.vars.BallPlayedCount = GlobalVars.vars.BallCount;
                            removeEventListener("addContact", contactAdded);
                            _loc_16 = new Burst_o();
                            _loc_16.x = this.x;
                            _loc_16.y = this.y;
                            _loc_16.height = 70;
                            _loc_16.width = 70;
                            world.addChild(_loc_16);
                            parent.removeChild(this);
                            _loc_17 = new Appeal();
                            _loc_5 = _loc_17.play();
                        }
                    }
                    else if ((_loc_2.name == "wicket" || _loc_2.name == "bail") && (_loc_3.name == "cball" || _loc_3.name == "bat"))
                    {
                        GlobalVars.vars.GameOver = true;
                        score_added = true;
                        GlobalVars.vars.BallPlayedCount = GlobalVars.vars.BallCount;
                        removeEventListener("addContact", contactAdded);
                        _loc_18 = world.getChildByName("bail");
                        _loc_18.b2body.WakeUp();
                        _loc_19 = new Stumps_sound();
                        _loc_5 = _loc_19.play();
                        _loc_17 = new Appeal();
                        _loc_5 = _loc_17.play();
                    }
                }
            }
            return;
        }// end function

    }
}
