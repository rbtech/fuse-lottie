using Uno;
using Uno.UX;
using Uno.Compiler.ExportTargetInterop;
using Uno.IO;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;
using RBT.Animation;

namespace RBT.Animation.Native.Android
{
	extern(!Android) class LottieView
	{
		[UXConstructor]
		public LottieView([UXParameter("Host")]RBT.Animation.ILottieEvents host) { }
	}

	[Require("Gradle.Dependency.Implementation", "com.airbnb.android:lottie:2.5.4")]
	extern(Android) class LottieView : Fuse.Controls.Native.Android.LeafView, ILottieView
	{
		RBT.Animation.ILottieEvents _host;

		[UXConstructor]
		public LottieView([UXParameter("Host")]RBT.Animation.ILottieEvents host) : base(Create())
		{
			_host = host;

			AddChangedCallback(onAnimationComplete, Handle);
		}

		/** EVENTS **/
		void onAnimationComplete(bool isCompleted)
		{
			_host.onAnimationComplete(isCompleted);
		}

		[Foreign(Language.Java)]
		void AddChangedCallback(Action<bool> onAnimationComplete, Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
			animationView.addAnimatorListener(new android.animation.Animator.AnimatorListener() {
				public void onAnimationStart(android.animation.Animator animation) {
					
				}
				public void onAnimationEnd(android.animation.Animator animation) {
					onAnimationComplete.run(true);
				}
				public void onAnimationRepeat(android.animation.Animator animation) {
					
				}
				public void onAnimationCancel(android.animation.Animator animation) {
					
				}
			});
		@}


		/** EVENT PROPERTIES **/
		//AnimationCompleted
		bool _AnimationCompletedValue = false;

		public bool AnimationCompleted
		{
			get { return _AnimationCompletedValue; }
			set { }
		}
		//EndAnimationCompleted








		/** PROPERTIES **/

		//AndroidImagesFolder
		string _AndroidImagesFolderValue = "/";

		public string AndroidImagesFolder
		{
			get { return _AndroidImagesFolderValue; }
			set { 
				_AndroidImagesFolderValue = value;
				SetAndroidImagesFolderValue(value, Handle); 
			}
		}

		[Foreign(Language.Java)]
		void SetAndroidImagesFolderValue(string androidImagesFolder, Java.Object lottieViewHandle)
		@{
			if (androidImagesFolder != "") {
				
				com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
				animationView.setImageAssetsFolder("" + androidImagesFolder);
			}
		@}
		//EndAndroidImagesFolder

		//File
		string _UrlToJSONValue = "";

		public string File
		{
			get { return _UrlToJSONValue; }
			set { 
				_UrlToJSONValue = value;
				SetUrlToJSONValue(value, Handle); 
			}
		}

		[Foreign(Language.Java)]
		void SetUrlToJSONValue(string urlToJSON, Java.Object lottieViewHandle)
		@{
			if (urlToJSON != "") {

				String bundleFilename = @{GetBundleFilename(string):Call(urlToJSON)};
				
				if (bundleFilename != "") {

					com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
					
					//keep previous settings
					boolean prevLoopAnimation = (animationView.getRepeatCount() == com.airbnb.lottie.LottieDrawable.INFINITE);
					boolean prevAutoReverseAnimation = (animationView.getRepeatMode() == com.airbnb.lottie.LottieDrawable.REVERSE);
					float prevAnimationSpeed = animationView.getSpeed();
					boolean isAnimationPlaying = animationView.isAnimating();

					animationView.setAnimation("" + bundleFilename);

					//restore previous settings
					if (prevLoopAnimation) {
						animationView.setRepeatCount(com.airbnb.lottie.LottieDrawable.INFINITE);
						animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.INFINITE);	
					} else {
						animationView.setRepeatCount(0);
						animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.RESTART);
					}
					if (prevAutoReverseAnimation) {
						animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.REVERSE);	
					} else {
						if (prevLoopAnimation) {
							animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.INFINITE);
						} else {
							animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.RESTART);
						}
					}
					animationView.setSpeed(prevAnimationSpeed);

					if (isAnimationPlaying) {
						animationView.setProgress(0);
						animationView.playAnimation();
					}
				}
			}
			
		@}
		//EndFile


		//ContentMode
		string _ContentModeValue = "";

		public string ContentMode
		{
			get { return _ContentModeValue; }
			set { 
				_ContentModeValue = value;
				SetContentModeValue(value, Handle); 
			}
		}

		[Foreign(Language.Java)]
		void SetContentModeValue(string contentMode, Java.Object lottieViewHandle)
		@{
			//iOS Only Feature, so we don't do anything here
		@}
		//EndContentMode


		//IsAnimationPlaying
		bool _IsAnimationPlayingValue = false;
		public bool IsAnimationPlaying
		{
			get { 
				_IsAnimationPlayingValue = GetIsAnimationPlayingValue(Handle);
				return _IsAnimationPlayingValue;
			}
			set {  }
		}

		[Foreign(Language.Java)]
		bool GetIsAnimationPlayingValue(Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
			return animationView.isAnimating();
		@}
		//EndIsAnimationPlaying


		//LoopAnimation
		bool _LoopAnimationValue = false;

		public bool LoopAnimation
		{
			get { 
				_LoopAnimationValue = GetLoopAnimationValue(Handle);
				return _LoopAnimationValue; 
			}
			set { 
				_LoopAnimationValue = value;
				SetLoopAnimationValue(value, Handle); 
			}
		}

		[Foreign(Language.Java)]
		bool GetLoopAnimationValue(Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
			return (animationView.getRepeatCount() == com.airbnb.lottie.LottieDrawable.INFINITE);
		@}

		[Foreign(Language.Java)]
		void SetLoopAnimationValue(bool loopAnimation, Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
			
			if (loopAnimation) {
				animationView.setRepeatCount(com.airbnb.lottie.LottieDrawable.INFINITE);
				if (animationView.getRepeatMode() == com.airbnb.lottie.LottieDrawable.REVERSE) {

				} else {
					animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.INFINITE);	
				}
				
			} else {
				animationView.setRepeatCount(0);

				if (animationView.getRepeatMode() == com.airbnb.lottie.LottieDrawable.REVERSE) {

				} else {
					animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.RESTART);	
				}	
			}
		@}
		//EndLoopAnimation


		//AutoReverseAnimation
		bool _AutoReverseAnimationValue = false;

		public bool AutoReverseAnimation
		{
			get { 
				_AutoReverseAnimationValue = GetAutoReverseAnimationValue(Handle);
				return _AutoReverseAnimationValue; 
			}
			set { 
				_AutoReverseAnimationValue = value;
				SetAutoReverseAnimationValue(value, Handle); 
			}
		}

		[Foreign(Language.Java)]
		bool GetAutoReverseAnimationValue(Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
			return (animationView.getRepeatMode() == com.airbnb.lottie.LottieDrawable.REVERSE);
		@}

		[Foreign(Language.Java)]
		void SetAutoReverseAnimationValue(bool autoReverseAnimation, Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
			
			if (autoReverseAnimation) {
				if (animationView.getRepeatMode() == com.airbnb.lottie.LottieDrawable.RESTART) {
					animationView.setRepeatCount(1);
				}
				animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.REVERSE);	
			} else {
				if (animationView.getRepeatCount() == com.airbnb.lottie.LottieDrawable.INFINITE) {
					animationView.setRepeatCount(com.airbnb.lottie.LottieDrawable.INFINITE);
					animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.INFINITE);
				} else {
					animationView.setRepeatCount(0);
					animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.RESTART);
				}
			
			}
			
		@}
		//EndAutoReverseAnimation


		//Play
		bool _PlayValue = false;

		public bool Play
		{
			get { 
				return _PlayValue; 
			}
			set { 
				_PlayValue = value;

				debug_log("PLAY: " + value);
				//reinitialise loop mode if its on
				if (_LoopAnimationValue) {
					SetLoopAnimationValue(true, Handle);
				}
				SetPlayValue(value, Handle); 
			}
		}

		[Foreign(Language.Java)]
		void SetPlayValue(bool play, Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
			if (play) {
				if (animationView.getRepeatMode() != com.airbnb.lottie.LottieDrawable.REVERSE && animationView.getRepeatMode() != com.airbnb.lottie.LottieDrawable.INFINITE) {
					animationView.setRepeatCount(0);
					animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.RESTART);
				}
				animationView.playAnimation();	
			}
			
		@}
		//EndPlay


		//Pause
		bool _PauseValue = false;

		public bool Pause
		{
			get { 
				return _PauseValue; 
			}
			set { 
				_PauseValue = value;
				debug_log("PAUSE");
				SetPauseValue(value, Handle); 
			}
		}

		[Foreign(Language.Java)]
		void SetPauseValue(bool pause, Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
			if (pause) {
				animationView.setRepeatCount(0);
				animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.RESTART);
				// animationView.setProgress(animationView.getProgress());
				animationView.pauseAnimation();
			}
			
		@}
		//EndPause


		//Stop
		bool _StopValue = false;

		public bool Stop
		{
			get { 
				return _StopValue; 
			}
			set { 
				_StopValue = value;
				debug_log("STOP");
				SetStopValue(value, Handle); 
			}
		}

		[Foreign(Language.Java)]
		void SetStopValue(bool stop, Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;
			if (stop) {

				animationView.setRepeatCount(0);
				animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.RESTART);
				animationView.cancelAnimation();
				// animationView.setProgress(0f);
			}
			
		@}
		//EndStop


		//Progress
		float _ProgressValue = 0f;

		public float Progress
		{
			get { return _ProgressValue; }
			set { 
				_ProgressValue = value;
				debug_log("SET PROGRESS");
				SetPauseValue(true, Handle);
				SetProgressValue(value, Handle); 
			}
		}

		[Foreign(Language.Java)]
		void SetProgressValue(float progress, Java.Object lottieViewHandle)
		@{
			com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) lottieViewHandle;

			animationView.setRepeatCount(0);
			animationView.setRepeatMode(com.airbnb.lottie.LottieDrawable.RESTART);
			animationView.setProgress(progress);	
		@}
		//EndProgress

		/** ENDPROPERTIES **/













		//Utils
		public static string GetBundleFilename(string imagePath)
		{

			var bundlePath = "";
			foreach(var f in Uno.IO.Bundle.AllFiles)
			{
				//debug_log("SourcePath: " + f.SourcePath);

				if (f.SourcePath == imagePath) {
					
					var bundleFileSource = new Uno.UX.BundleFileSource(f);

					//var bundleFileSource = fileSource as BundleFileSource;
					if (bundleFileSource != null) {
						bundlePath = bundleFileSource.BundleFile.BundlePath;
						break;
					} else {
						bundlePath = "";
					}
				}
			}

			return bundlePath;
		}


		public override void Dispose()
		{
			base.Dispose();
			_host = null;
		}

		public void Update()
		{

		}

		public void OnRooted()
		{
			UpdateManager.AddAction(Update);
		}

		public void OnUnrooted()
		{
			UpdateManager.RemoveAction(Update);
		}


		[Foreign(Language.Java)]
		static Java.Object Create()
		@{
			//setContentView(R.layout.activity_main);

			//com.fuse.Activity.getRootActivity().getWindow().setContentView(@(Activity.Package).R.layout.activity_main);
			//com.airbnb.lottie.LottieAnimationView animationView = (com.airbnb.lottie.LottieAnimationView) com.fuse.Activity.getRootActivity().getWindow().findViewById(@(Activity.Package).R.id.lottie_animation_view);
			
			 

			//return new android.widget.DatePicker(@(Activity.Package).@(Activity.Name).GetRootActivity());
			return new com.airbnb.lottie.LottieAnimationView(com.fuse.Activity.getRootActivity());
		@}

	}
}
