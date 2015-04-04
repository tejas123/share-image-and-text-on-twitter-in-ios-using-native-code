using UnityEngine;
using System.Collections;
using System.IO;
using System.Runtime.InteropServices;

public class Twitter_Sharing : MonoBehaviour
{
	public Texture2D MyImage;

	public void OnEnable ()
	{
		ScreenshotHandler.ScreenshotFinishedSaving += ScreenshotSaved;
		
	}
	
	void OnDisable()
	{
		ScreenshotHandler.ScreenshotFinishedSaving -= ScreenshotSaved;
		
	}

	#if UNITY_IPHONE
	
	[DllImport("__Internal")]
	private static extern void TwitterTextSharingMethod (string message);

	[DllImport("__Internal")]
	private static extern void TwitterImageSharing (string iosPath, string message);

	#endif

	public void OnTwitterTextSharingClick()
	{
#if UNITY_IPHONE || UNITY_IPAD
		string shareMessage = "Wow I Just Share Text On Twitter ";
		TwitterTextSharingMethod(shareMessage);
#endif


	}
	public void OniOSTwitterMediaSharing()
	{
		Debug.Log("Media Share");
		byte[] bytes = MyImage.EncodeToPNG();
		string path = Application.persistentDataPath + "/MyImage.png";
		File.WriteAllBytes(path, bytes);
		
		string path_ =  "MyImage.png";
		StartCoroutine(ScreenshotHandler.Save(path_, "Media Share", true));
	}
	
	void ScreenshotSaved ()
	{
		
		#if UNITY_IPHONE || UNITY_IPAD
		string shareMessage = "Wow I Just Share Image ";
		TwitterImageSharing (ScreenshotHandler.savedImagePath, shareMessage);
		#endif
		
	}
}
