using Uno;
using Uno.UX;
using Uno.Compiler.ExportTargetInterop;

using Fuse;
using Fuse.Controls.Native;
using Fuse.Scripting;

namespace RBT.Animation
{
	using Fuse.Controls.Native.iOS;
	using Fuse.Controls.Native.Android;

	interface ILottieView
	{
		string File { set; }
		string AndroidImagesFolder { set; }
		string ContentMode { set; }
		bool IsAnimationPlaying { get; set; }
		bool LoopAnimation { set; }
		bool AutoReverseAnimation { set; }
		bool Play { set; }
		bool Pause { set; }
		bool Stop { set; }
		float Progress { set; }

		void OnRooted();
		void OnUnrooted();
	}

	interface ILottieEvents
	{
		void onAnimationComplete(bool isCompleted);
	}

	public abstract partial class LottieBase : Fuse.Controls.Panel, ILottieEvents
	{

		/** EVENTS **/
		void ILottieEvents.onAnimationComplete(bool isComplete)
		{
			SetAnimationCompletedValue(isComplete, null);
		}


		/** EVENT PROPERTIES **/
		//AnimationCompleted - Animation Completed
		bool _AnimationCompletedValue = false;

		static Selector _AnimationCompletedProperty = "AnimationCompleted";
		
		[UXOriginSetter("SetAnimationCompletedValue")]

		public bool AnimationCompleted
		{
			get { return _AnimationCompletedValue; }
			set { SetAnimationCompletedValue(value, this); }
		}

		public void SetAnimationCompletedValue(bool value, IPropertyListener origin)
		{
			_AnimationCompletedValue = value;
			OnPropertyChanged(_AnimationCompletedProperty, origin);
		}
		//EndAnimationCompleted



		/** PROPERTIES **/

		//AndroidImagesFolder - Sets the images animation folder for android
		string _AndroidImagesFolderValue = "/";

		static Selector _AndroidImagesFolderProperty = "AndroidImagesFolder";
		
		[UXOriginSetter("SetAndroidImagesFolderValue")]

		public string AndroidImagesFolder
		{
			get { return _AndroidImagesFolderValue; }
			set { SetAndroidImagesFolderValue(value, this); }
		}

		public void SetAndroidImagesFolderValue(string value, IPropertyListener origin)
		{
			if (value != _AndroidImagesFolderValue)
			{
				_AndroidImagesFolderValue = value;
				
				OnPropertyChanged(_AndroidImagesFolderProperty, origin);
			}

			var lv = LottieView;
			if (lv != null)
				lv.AndroidImagesFolder = value;
		}
		//EndAndroidImagesFolder


		//File - Load animation from a bundled .json file
		string _UrlToJSONValue = "";

		static Selector _UrlToJSONProperty = "File";
		
		[UXOriginSetter("SetUrlToJSONValue")]

		public string File
		{
			get { return _UrlToJSONValue; }
			set { SetUrlToJSONValue(value, this); }
		}

		public void SetUrlToJSONValue(string value, IPropertyListener origin)
		{
			if (value != _UrlToJSONValue)
			{
				_UrlToJSONValue = value;
				
				OnPropertyChanged(_UrlToJSONProperty, origin);
			}

			var lv = LottieView;
			if (lv != null)
				lv.File = value;
		}
		//EndFile


		//ContentMode - iOS + Set Only - sets visual mode of content such as: Scale Aspect Fit
		string _ContentModeValue = "";

		static Selector _ContentModeProperty = "ContentMode";
		
		[UXOriginSetter("SetContentModeValue")]

		public string ContentMode
		{
			get { return _ContentModeValue; }
			set { SetContentModeValue(value, this); }
		}

		public void SetContentModeValue(string value, IPropertyListener origin)
		{
			if (value != _ContentModeValue)
			{
				_ContentModeValue = value;
				
				OnPropertyChanged(_ContentModeProperty, origin);
			}

			var lv = LottieView;
			if (lv != null) 
				lv.ContentMode = value;
		}
		//EndContentMode


		//IsAnimationPlaying - Read Only - true/false if animation is playing
		bool _IsAnimationPlayingValue = false;
		static Selector _IsAnimationPlayingProperty = "LoopAnimation";
		public bool IsAnimationPlaying
		{
			get { 
				var lv = LottieView;
				if (lv != null)
					return lv.IsAnimationPlaying;
				return false;
			}
			set {  }
		}
		//EndIsAnimationPlaying


		//LoopAnimation - Tells the animation to loop indefinitely. Defaults to false.
		bool _LoopAnimationValue = false;

		static Selector _LoopAnimationProperty = "LoopAnimation";
		
		[UXOriginSetter("SetLoopAnimationValue")]

		public bool LoopAnimation
		{
			get { return _LoopAnimationValue; }
			set { SetLoopAnimationValue(value, this); }
		}

		public void SetLoopAnimationValue(bool value, IPropertyListener origin)
		{
			if (value != _LoopAnimationValue)
			{
				_LoopAnimationValue = value;
				
				OnPropertyChanged(_LoopAnimationProperty, origin);
			}

			var lv = LottieView;
			if (lv != null)
				lv.LoopAnimation = value;
				
		}
		//EndLoopAnimation


		//AutoReverseAnimation - The animation will play forward and then backwards if loopAnimation is also true
		bool _AutoReverseAnimationValue = false;

		static Selector _AutoReverseAnimationProperty = "AutoReverseAnimation";
		
		[UXOriginSetter("SetAutoReverseAnimationValue")]

		public bool AutoReverseAnimation
		{
			get { return _AutoReverseAnimationValue; }
			set { SetAutoReverseAnimationValue(value, this); }
		}

		public void SetAutoReverseAnimationValue(bool value, IPropertyListener origin)
		{
			if (value != _AutoReverseAnimationValue)
			{
				_AutoReverseAnimationValue = value;
				
				OnPropertyChanged(_AutoReverseAnimationProperty, origin);
			}

			var lv = LottieView;
			if (lv != null)
				lv.AutoReverseAnimation = value;
				
		}
		//EndAutoReverseAnimation




		/*
		 Plays the animation from its current position to the end of the animation.
		 The animation will start from its current position.
		 If loopAnimation is true the animation will loop from beginning to end indefinitely.
		 If loopAnimation is false the animation will stop and the completion event will be called.
		*/
		bool _PlayValue = false;

		static Selector _PlayProperty = "Play";
		
		[UXOriginSetter("SetPlayValue")]

		public bool Play
		{
			get { return _PlayValue; }
			set { SetPlayValue(value, this); }
		}

		public void SetPlayValue(bool value, IPropertyListener origin)
		{
			if (value != _PlayValue)
			{
				_PlayValue = value;
				
				OnPropertyChanged(_PlayProperty, origin);

				//reset stop, play & progress
				_StopValue = false;
				OnPropertyChanged(_StopProperty, origin);

				_PauseValue = false;
				OnPropertyChanged(_PauseProperty, origin);

				_ProgressValue = 0f;
				OnPropertyChanged(_ProgressProperty, origin);
			}

			var lv = LottieView;
			if (lv != null)
				lv.Play = value;
				
		}
		//EndPlay


		//Pause - Stops the animation at the current frame.
		bool _PauseValue = false;

		static Selector _PauseProperty = "Pause";
		
		[UXOriginSetter("SetPauseValue")]

		public bool Pause
		{
			get { return _PauseValue; }
			set { SetPauseValue(value, this); }
		}

		public void SetPauseValue(bool value, IPropertyListener origin)
		{
			if (value != _PauseValue)
			{
				_PauseValue = value;
				
				OnPropertyChanged(_PauseProperty, origin);

				//reset play & stop
				_PlayValue = false;
				OnPropertyChanged(_PlayProperty, origin);

				_StopValue = false;
				OnPropertyChanged(_StopProperty, origin);
			}

			var lv = LottieView;
			if (lv != null)
				lv.Pause = value;
				
		}
		//EndPause


		//Stop - Stops the animation and rewinds to the beginning.
		bool _StopValue = false;

		static Selector _StopProperty = "Stop";
		
		[UXOriginSetter("SetStopValue")]

		public bool Stop
		{
			get { return _StopValue; }
			set { SetStopValue(value, this); }
		}

		public void SetStopValue(bool value, IPropertyListener origin)
		{
			if (value != _StopValue)
			{
				_StopValue = value;
				
				OnPropertyChanged(_StopProperty, origin);

				//reset play & pause
				_PlayValue = false;
				OnPropertyChanged(_PlayProperty, origin);

				_PauseValue = false;
				OnPropertyChanged(_PauseProperty, origin);
			}

			var lv = LottieView;
			if (lv != null)
				lv.Stop = value;
				
		}
		//EndStop

		/*  Sets a progress from 0 - 1 of the animation. If the animation is playing it will stop.
				The current progress of the animation in absolute time.
				e.g. a value of 0.75 always represents the same point in the animation, regardless of positive
				or negative speed.
		*/
		float _ProgressValue = 0f;

		static Selector _ProgressProperty = "Progress";
		
		[UXOriginSetter("SetProgressValue")]

		public float Progress
		{
			get { return _ProgressValue; }
			set { SetProgressValue(value, this); }
		}

		public void SetProgressValue(float value, IPropertyListener origin)
		{
			if (value != _ProgressValue)
			{
				_ProgressValue = value;
				
				OnPropertyChanged(_ProgressProperty, origin);

				//reset play, pause & stop
				_PlayValue = false;
				OnPropertyChanged(_PlayProperty, origin);

				_PauseValue = false;
				OnPropertyChanged(_PauseProperty, origin);

				_StopValue = false;
				OnPropertyChanged(_StopProperty, origin);
			}

			var lv = LottieView;
			if (lv != null) 
				lv.Progress = value;
		}
		//EndProgress

		/** ENDPROPERTIES **/






		protected override void OnRooted()
		{
			base.OnRooted();

			var lv = LottieView;
			if (lv != null)
				lv.OnRooted();
		}

		protected override void OnUnrooted()
		{
			var lv = LottieView;
			if (lv != null)
				lv.OnUnrooted();

			base.OnUnrooted();
		}

		ILottieView LottieView
		{
			get { return (ILottieView)NativeView; }
		}
	}
}
