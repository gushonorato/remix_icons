defmodule RemixIconsTest do
  use ExUnit.Case
  import Phoenix.LiveViewTest

  setup do
    # Clear the cache before each test
    start_supervised(RemixIcons.cache())
    Cachex.clear(:icons)
    :ok
  end

  test "renders an existing icon" do
    result = render_component(&RemixIcons.icon/1, %{name: "home-fill"})

    # Verify the SVG content is included
    assert result =~ "<svg"
    assert result =~ "viewBox"
  end

  test "caches icon templates" do
    # First call should cache the template
    result1 = render_component(&RemixIcons.icon/1, %{name: "home-fill"})

    # Second call should use cached template
    result2 = render_component(&RemixIcons.icon/1, %{name: "home-fill"})

    # Both should render the same content
    assert result1 == result2
    assert result1 =~ "<svg"
  end

  test "raises error when icon is not found" do
    assert_raise Cachex.Error, ~r/Icon non-existent-icon not found/, fn ->
      render_component(&RemixIcons.icon/1, %{name: "non-existent-icon"})
    end
  end

  test "renders different icons correctly" do
    icon_names = ["home-fill", "home-line", "bank-fill", "bank-line"]

    for icon_name <- icon_names do
      result = render_component(&RemixIcons.icon/1, %{name: icon_name})

      assert result =~ "<svg"
      assert result =~ "viewBox"
    end
  end

  test "handles icon names with different cases" do
    # Test that the icon lookup is case-sensitive
    assert_raise Cachex.Error, ~r/Icon HOME-FILL not found/, fn ->
      render_component(&RemixIcons.icon/1, %{name: "HOME-FILL"})
    end
  end
end
